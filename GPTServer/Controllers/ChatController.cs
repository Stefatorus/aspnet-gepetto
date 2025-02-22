using Anthropic.SDK;
using Anthropic.SDK.Messaging;
using GPTServer.Data;
using GPTServer.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Text.Json;
using Message = GPTServer.Models.Message;
using AnthropicMessage = Anthropic.SDK.Messaging.Message;

namespace GPTServer.Controllers;

[Authorize]
public class ChatController : Controller
{
    private readonly AnthropicClient _anthropicClient;
    private readonly ApplicationDbContext _context;
    private readonly UserManager<IdentityUser> _userManager;

    public ChatController(ApplicationDbContext context, UserManager<IdentityUser> userManager, AnthropicClient anthropicClient)
    {
        _context = context;
        _userManager = userManager;
        _anthropicClient = anthropicClient;
    }

    // Index - Afiseaza conversatiile utilizatorului logat si modelele disponibile
    public IActionResult Index()
    {
        var userId = _userManager.GetUserId(User);
        var conversatii = _context.Conversations.Where(c => c.UserId == userId).ToList();
        var modeleDisponibile = new List<string> { "claude-3-5-haiku-20241022" };
        if (User.IsInRole("Claude-Sonnet"))
            modeleDisponibile.Add("claude-3-5-sonnet-20241022");

        return View(new ChatViewModel { Conversations = conversatii, AvailableModels = modeleDisponibile });
    }

    // GetMessages - Preia mesajele dintr-o conversatie si le returneaza ca JSON
    [HttpGet]
    public async Task<IActionResult> GetMessages(int conversationId)
    {
        var userId = _userManager.GetUserId(User);
        var conversatie = await _context.Conversations.Include(c => c.Messages)
                                  .FirstOrDefaultAsync(c => c.Id == conversationId);
        if (conversatie == null || conversatie.UserId != userId)
            return NotFound();

        var mesaje = conversatie.Messages.OrderBy(m => m.Timestamp)
            .Select(m => new 
            { 
                sender = m.Sender, 
                content = m.Content, 
                timestamp = m.Timestamp 
            }).ToList();
        return Json(mesaje);
    }

    // SendMessage - Creeaza mesajul utilizatorului, construieste istoricul, apeleaza API-ul Anthropic in streaming,
    // concateneaza raspunsul si il salveaza in DB.
    [HttpPost]
    public async Task<IActionResult> SendMessage([FromBody] SendMessageRequest request)
    {
        var userId = _userManager.GetUserId(User);
        var conversatie = _context.Conversations.Include(c => c.Messages)
                              .FirstOrDefault(c => c.Id == request.ConversationId);
        if (conversatie == null || conversatie.UserId != userId)
            return NotFound();

        if (request.Model == "claude-3-5-sonnet-20241022" && !User.IsInRole("Claude-Sonnet"))
            return Forbid();
        if (request.Model != "claude-3-5-sonnet-20241022" && request.Model != "claude-3-5-haiku-20241022")
            return Forbid();

        // Creeaza mesajul de la utilizator si il adauga in conversatie
        var mesajUtilizator = new Message
        {
            Sender = "User",
            Content = request.MessageContent,
            Timestamp = DateTime.Now
        };
        conversatie.Messages.Add(mesajUtilizator);
        await _context.SaveChangesAsync();

        // Construieste istoricul mesajelor pentru Anthropic.
        // Daca un mesaj e PDF (se deserializa in PdfDto), se trimite ca DocumentContent; altfel ca TextContent.
        var istoricMesaje = conversatie.Messages.OrderBy(m => m.Timestamp)
            .Select(m =>
            {
                try
                {
                    var pdfDto = JsonSerializer.Deserialize<PdfDto>(m.Content);
                    if (pdfDto != null && !string.IsNullOrWhiteSpace(pdfDto.pdfBase64))
                    {
                        return new AnthropicMessage
                        {
                            Role = m.Sender == "User" ? RoleType.User : RoleType.Assistant,
                            Content = new List<ContentBase>
                            {
                                new DocumentContent
                                {
                                    Source = new ImageSource { Data = pdfDto.pdfBase64, MediaType = "application/pdf" },
                                    CacheControl = new CacheControl { Type = CacheControlType.ephemeral }
                                }
                            }
                        };
                    }
                }
                catch { }
                return new AnthropicMessage
                {
                    Role = m.Sender == "User" ? RoleType.User : RoleType.Assistant,
                    Content = new List<ContentBase> { new TextContent { Text = m.Content } }
                };
            }).ToList();

        var parameters = new MessageParameters
        {
            Messages = istoricMesaje,
            MaxTokens = 4048,
            Model = request.Model,
            Stream = true,
            Temperature = 1.0m
        };

        var outputs = new List<MessageResponse>();
        await foreach (var res in _anthropicClient.Messages.StreamClaudeMessageAsync(parameters))
        {
            if (res.Delta != null)
                Console.Write(res.Delta.Text);
            outputs.Add(res);
        }

        var raspunsContinut = string.Join("", outputs.Select(o => o.Delta?.Text)) ?? "";
        var mesajRaspuns = new Message
        {
            Sender = "Anthropic",
            Content = raspunsContinut,
            Timestamp = DateTime.Now
        };
        conversatie.Messages.Add(mesajRaspuns);
        await _context.SaveChangesAsync();

        return Ok(new { userMessage = mesajUtilizator, responseMessage = mesajRaspuns });
    }

    // UploadPdf - Converteste PDF-ul uploadat in base64 si il salveaza ca mesaj in DB
    [HttpPost]
    public async Task<IActionResult> UploadPdf([FromBody] UploadPdfRequest request)
    {
        var userId = _userManager.GetUserId(User);
        var conversatie = _context.Conversations.Include(c => c.Messages)
                              .FirstOrDefault(c => c.Id == request.ConversationId);
        if (conversatie == null || conversatie.UserId != userId)
            return NotFound();

        if (request.PdfBase64.Length > 9_000_000)
            return BadRequest("Fisierul PDF este prea mare pentru procesare.");

        var pdfInfo = new { pdfBase64 = request.PdfBase64, fileName = string.IsNullOrWhiteSpace(request.FileName) ? "document.pdf" : request.FileName };
        string contentJson = JsonSerializer.Serialize(pdfInfo);
        var mesajPdf = new Message
        {
            Sender = "User",
            Content = contentJson,
            Timestamp = DateTime.Now
        };
        conversatie.Messages.Add(mesajPdf);
        await _context.SaveChangesAsync();
        return Ok(mesajPdf);
    }

    // StreamMessage - Endpoint SSE care transmite in timp real textul primit de la Anthropic,
    // apoi salveaza mesajul complet in DB
    [HttpGet("Chat/StreamMessage")]
    public async Task StreamMessage(int conversationId, string messageContent, string model)
    {
        Response.ContentType = "text/event-stream";
        var userId = _userManager.GetUserId(User);
        var conversatie = _context.Conversations.Include(c => c.Messages)
                              .FirstOrDefault(c => c.Id == conversationId);
        if (conversatie == null || conversatie.UserId != userId)
        {
            await Response.WriteAsync("event: error\ndata: Conversatie inexistenta sau neautorizata\n\n");
            return;
        }
        if (model == "claude-3-5-sonnet-20241022" && !User.IsInRole("Claude-Sonnet"))
        {
            await Response.WriteAsync("event: error\ndata: Acces interzis\n\n");
            return;
        }
        if (model != "claude-3-5-sonnet-20241022" && model != "claude-3-5-haiku-20241022")
        {
            await Response.WriteAsync("event: error\ndata: Model invalid\n\n");
            return;
        }

        var mesajUtilizator = new Message
        {
            Sender = "User",
            Content = messageContent,
            Timestamp = DateTime.Now
        };
        conversatie.Messages.Add(mesajUtilizator);
        await _context.SaveChangesAsync();

        var istoricMesaje = conversatie.Messages.OrderBy(m => m.Timestamp)
            .Select(m => new AnthropicMessage
            {
                Role = m.Sender == "User" ? RoleType.User : RoleType.Assistant,
                Content = new List<ContentBase> { new TextContent { Text = m.Content } }
            }).ToList();

        var parameters = new MessageParameters
        {
            Messages = istoricMesaje,
            MaxTokens = 4048,
            Model = model,
            Stream = true,
            Temperature = 1.0m
        };

        string textFinal = "";
        await foreach (var res in _anthropicClient.Messages.StreamClaudeMessageAsync(parameters))
        {
            if (res.Delta != null && !string.IsNullOrEmpty(res.Delta.Text))
            {
                textFinal += res.Delta.Text;
                string dataEvent = $"data: {res.Delta.Text.Replace("\n", "\\n")}\n\n";
                await Response.WriteAsync(dataEvent);
                await Response.Body.FlushAsync();
            }
        }
        await Response.WriteAsync("event: end\ndata: end\n\n");

        // Salveaza mesajul complet de la Anthropic in DB
        var mesajRaspuns = new Message
        {
            Sender = "Anthropic",
            Content = textFinal,
            Timestamp = DateTime.Now
        };
        conversatie.Messages.Add(mesajRaspuns);
        await _context.SaveChangesAsync();
    }

    // CreateConversation - Creeaza o conversatie noua pentru utilizatorul logat
    [HttpGet]
    public async Task<IActionResult> CreateConversation()
    {
        var userId = _userManager.GetUserId(User);
        if (string.IsNullOrEmpty(userId))
            return Unauthorized();
        var conversatieNoua = new Conversation
        {
            UserId = userId,
            Title = $"Conversatie {_context.Conversations.Count() + 1}"
        };
        _context.Conversations.Add(conversatieNoua);
        await _context.SaveChangesAsync();
        return RedirectToAction("Index");
    }
}

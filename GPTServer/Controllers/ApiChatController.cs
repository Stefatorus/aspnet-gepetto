using System.Text.Json;
using Anthropic.SDK;
using Anthropic.SDK.Messaging;
using GPTServer.Data;
using GPTServer.Models;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Message = GPTServer.Models.Message;
using AnthropicMessage = Anthropic.SDK.Messaging.Message;

namespace GPTServer.Controllers;

[Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
[ApiController]
[Route("api/[controller]")]
public class ApiChatController : ControllerBase
{
    private readonly AnthropicClient _anthropicClient;
    private readonly ApplicationDbContext _context;
    private readonly ILogger<ApiChatController> _logger;
    private readonly UserManager<IdentityUser> _userManager;

    public ApiChatController(
        AnthropicClient anthropicClient,
        ApplicationDbContext context,
        UserManager<IdentityUser> userManager,
        ILogger<ApiChatController> logger)
    {
        _anthropicClient = anthropicClient;
        _context = context;
        _userManager = userManager;
        _logger = logger;
    }

    [HttpGet("messages")]
    public async Task<IActionResult> GetMessages(int conversationId)
    {
        var userId = _userManager.GetUserId(User);
        var conversation = await _context.Conversations
            .Include(c => c.Messages)
            .FirstOrDefaultAsync(c => c.Id == conversationId && c.UserId == userId);

        if (conversation == null)
        {
            _logger.LogWarning("GetMessages: Conversation {ConversationId} not found for user {UserId}.",
                conversationId, userId);
            return NotFound();
        }

        var messages = conversation.Messages
            .OrderBy(m => m.Timestamp)
            .Select(m => new {sender = m.Sender, content = m.Content, timestamp = m.Timestamp})
            .ToList();

        return Ok(messages);
    }

    [HttpPost("sendmessage")]
    public async Task<IActionResult> SendMessage([FromBody] SendMessageRequest request)
    {
        var userId = _userManager.GetUserId(User);
        var conversation = await _context.Conversations
            .Include(c => c.Messages)
            .FirstOrDefaultAsync(c => c.Id == request.ConversationId && c.UserId == userId);

        if (conversation == null)
        {
            _logger.LogWarning("SendMessage: Conversation {ConversationId} not found for user {UserId}.",
                request.ConversationId, userId);
            return NotFound();
        }

        if (request.Model == "claude-3-5-sonnet-20241022" && !User.IsInRole("Claude-Sonnet"))
        {
            _logger.LogWarning("SendMessage: Unauthorized model access for user {UserId}.", userId);
            return Forbid();
        }

        if (request.Model != "claude-3-5-sonnet-20241022" && request.Model != "claude-3-5-haiku-20241022")
        {
            _logger.LogWarning("SendMessage: Invalid model {Model} requested by user {UserId}.", request.Model, userId);
            return Forbid();
        }

        var userMessage = new Message
        {
            Sender = "User",
            Content = request.MessageContent,
            Timestamp = DateTime.Now
        };
        conversation.Messages.Add(userMessage);
        await _context.SaveChangesAsync();

        var messageHistory = conversation.Messages.OrderBy(m => m.Timestamp)
            .Select(m =>
            {
                try
                {
                    var pdfDto = JsonSerializer.Deserialize<PdfDto>(m.Content);
                    if (pdfDto != null && !string.IsNullOrWhiteSpace(pdfDto.pdfBase64))
                        return new AnthropicMessage
                        {
                            Role = m.Sender == "User" ? RoleType.User : RoleType.Assistant,
                            Content = new List<ContentBase>
                            {
                                new DocumentContent
                                {
                                    Source = new ImageSource {Data = pdfDto.pdfBase64, MediaType = "application/pdf"},
                                    CacheControl = new CacheControl {Type = CacheControlType.ephemeral}
                                }
                            }
                        };
                }
                catch (Exception ex)
                {
                    _logger.LogError(ex, "SendMessage: Error deserializing PDF data.");
                }

                return new AnthropicMessage
                {
                    Role = m.Sender == "User" ? RoleType.User : RoleType.Assistant,
                    Content = new List<ContentBase> {new TextContent {Text = m.Content}}
                };
            }).ToList();

        var parameters = new MessageParameters
        {
            Messages = messageHistory,
            MaxTokens = 4048,
            Model = request.Model,
            Stream = false, // Non-streaming for API endpoints
            Temperature = 1.0m
        };

        var response = await _anthropicClient.Messages.GetClaudeMessageAsync(parameters);
        var responseContent = response.Delta?.Text ?? "";
        var assistantMessage = new Message
        {
            Sender = "Anthropic",
            Content = responseContent,
            Timestamp = DateTime.Now
        };
        conversation.Messages.Add(assistantMessage);
        await _context.SaveChangesAsync();

        _logger.LogInformation("SendMessage: Successfully processed message for conversation {ConversationId}.",
            request.ConversationId);
        return Ok(new {userMessage, responseMessage = assistantMessage});
    }

    [HttpPost("uploadpdf")]
    public async Task<IActionResult> UploadPdf([FromBody] UploadPdfRequest request)
    {
        var userId = _userManager.GetUserId(User);
        var conversation = await _context.Conversations
            .Include(c => c.Messages)
            .FirstOrDefaultAsync(c => c.Id == request.ConversationId && c.UserId == userId);

        if (conversation == null)
        {
            _logger.LogWarning("UploadPdf: Conversation {ConversationId} not found for user {UserId}.",
                request.ConversationId, userId);
            return NotFound();
        }

        if (request.PdfBase64.Length > 9_000_000)
        {
            _logger.LogWarning("UploadPdf: PDF too large for conversation {ConversationId} by user {UserId}.",
                request.ConversationId, userId);
            return BadRequest("PDF file is too large for processing.");
        }

        var pdfInfo = new {pdfBase64 = request.PdfBase64, fileName = request.FileName ?? "document.pdf"};
        var contentJson = JsonSerializer.Serialize(pdfInfo);
        var pdfMessage = new Message
        {
            Sender = "User",
            Content = contentJson,
            Timestamp = DateTime.Now
        };
        conversation.Messages.Add(pdfMessage);
        await _context.SaveChangesAsync();

        _logger.LogInformation("UploadPdf: PDF uploaded for conversation {ConversationId}.", request.ConversationId);
        return Ok(pdfMessage);
    }

    [HttpGet("createconversation")]
    public async Task<IActionResult> CreateConversation()
    {
        var userId = _userManager.GetUserId(User);
        if (string.IsNullOrEmpty(userId))
        {
            _logger.LogWarning("CreateConversation: Unauthorized access attempt.");
            return Unauthorized();
        }

        var newConversation = new Conversation
        {
            UserId = userId,
            Title = $"Conversation {await _context.Conversations.CountAsync() + 1}"
        };
        _context.Conversations.Add(newConversation);
        await _context.SaveChangesAsync();

        _logger.LogInformation("CreateConversation: New conversation {ConversationId} created for user {UserId}.",
            newConversation.Id, userId);
        return Ok(newConversation);
    }
}
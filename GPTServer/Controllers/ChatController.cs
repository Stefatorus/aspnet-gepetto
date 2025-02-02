using Anthropic.SDK;
using Anthropic.SDK.Messaging;
using GPTServer.Data;
using GPTServer.Models;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Message = GPTServer.Models.Message;
using AnthropicMessage = Anthropic.SDK.Messaging.Message;

namespace GPTServer.Controllers;

public class ChatController : Controller
{
    private readonly AnthropicClient _anthropicClient;
    private readonly ApplicationDbContext _context;
    private readonly UserManager<IdentityUser> _userManager;

    public ChatController(ApplicationDbContext context, UserManager<IdentityUser> userManager,
        AnthropicClient anthropicClient)
    {
        _context = context;
        _userManager = userManager;
        _anthropicClient = anthropicClient;
    }

    public IActionResult Index()
    {
        var userId = _userManager.GetUserId(User);
        var conversations = _context.Conversations
            .Where(c => c.UserId == userId)
            .ToList();

        var availableModels = new List<string> {"claude-3-5-haiku-20241022"};
        if (User.IsInRole("Claude-Sonnet")) availableModels.Add("claude-3-5-sonnet-20241022");

        return View(new ChatViewModel {Conversations = conversations, AvailableModels = availableModels});
    }

    [HttpGet]
    public IActionResult ViewConversation(int id)
    {
        var conversation = _context.Conversations
            .Include(c => c.Messages)
            .FirstOrDefault(c => c.Id == id);
        if (conversation == null || conversation.UserId != _userManager.GetUserId(User)) return NotFound();
        return View(conversation);
    }

    // File: GPTServer/Controllers/ChatController.cs
    [HttpPost]
    public async Task<IActionResult> SendMessage([FromBody] SendMessageRequest request)
    {
        var userId = _userManager.GetUserId(User);
        var conversation = _context.Conversations
            .Include(c => c.Messages)
            .FirstOrDefault(c => c.Id == request.ConversationId);
        if (conversation == null || conversation.UserId != userId) return NotFound();

        // Check if the user has access to the specified model
        if (request.Model == "claude-3-5-sonnet-20241022" && !User.IsInRole("Claude-Sonnet")) return Forbid();
        if (request.Model != "claude-3-5-sonnet-20241022" && request.Model != "claude-3-5-haiku-20241022") return Forbid();

        // Retrieve the message history in chronological order
        var messageHistory = conversation.Messages
            .OrderBy(m => m.Timestamp)
            .Select(m => new AnthropicMessage
            {
                Role = m.Sender == "User" ? RoleType.User : RoleType.Assistant,
                Content = new List<ContentBase> {new TextContent {Text = m.Content}}
            })
            .ToList();

        // Add the new user message to the history
        messageHistory.Add(new AnthropicMessage
        {
            Role = RoleType.User,
            Content = new List<ContentBase> {new TextContent {Text = request.MessageContent}}
        });

        var parameters = new MessageParameters
        {
            Messages = messageHistory,
            MaxTokens = 4048,
            Model = request.Model,
            Stream = true,
            Temperature = 1.0m
        };

        var outputs = new List<MessageResponse>();
        await foreach (var res in _anthropicClient.Messages.StreamClaudeMessageAsync(parameters))
        {
            if (res.Delta != null) Console.Write(res.Delta.Text);

            outputs.Add(res);
        }

        var responseMessage = new Message
        {
            Content = string.Join("", outputs.Select(o => o.Delta?.Text)),
            Sender = "Anthropic",
            Timestamp = DateTime.Now
        };

        conversation.Messages.Add(responseMessage);
        await _context.SaveChangesAsync();

        return Ok(responseMessage);
    }

    [HttpGet]
    public async Task<IActionResult> CreateConversation()
    {
        var userId = _userManager.GetUserId(User);
        var newConversation = new Conversation
        {
            UserId = userId,
            Title = $"Conversation {_context.Conversations.Count() + 1}"
        };

        _context.Conversations.Add(newConversation);
        await _context.SaveChangesAsync();
        return RedirectToAction("Index");
    }

    [HttpGet]
    public async Task<IActionResult> GetMessages(int conversationId)
    {
        var conversation = await _context.Conversations
            .Include(c => c.Messages)
            .FirstOrDefaultAsync(c => c.Id == conversationId);

        if (conversation == null || conversation.UserId != _userManager.GetUserId(User)) return NotFound();

        var messages = conversation.Messages.Select(m => new
        {
            m.Sender,
            m.Content,
            m.Timestamp
        }).ToList();

        return Json(messages);
    }
}
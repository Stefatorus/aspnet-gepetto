using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;

namespace GPTServer.Controllers;

using GPTServer.Data;
using GPTServer.Models;
using Microsoft.AspNetCore.Mvc;
using System.Linq;
using System.Threading.Tasks;

public class ChatController : Controller
{
    private readonly ApplicationDbContext _context;
    private readonly UserManager<IdentityUser> _userManager;

    public ChatController(ApplicationDbContext context, UserManager<IdentityUser> userManager)
    {
        _context = context;
        _userManager = userManager;
    }

    public IActionResult Index()
    {
        var userId = _userManager.GetUserId(User);
        var conversations = _context.Conversations
            .Where(c => c.UserId == userId)
            .ToList();
        return View(new ChatViewModel { Conversations = conversations });
    }

    [HttpGet]
    public IActionResult ViewConversation(int id)
    {
        var conversation = _context.Conversations
            .Include(c => c.Messages)
            .FirstOrDefault(c => c.Id == id);
        if (conversation == null || conversation.UserId != _userManager.GetUserId(User))
        {
            return NotFound();
        }
        return View(conversation);
    }

    [HttpPost]
    public async Task<IActionResult> SendMessage(int conversationId, string messageContent)
    {
        var conversation = _context.Conversations
            .Include(c => c.Messages)
            .FirstOrDefault(c => c.Id == conversationId);
        if (conversation == null || conversation.UserId != _userManager.GetUserId(User))
        {
            return NotFound();
        }

        var message = new Message
        {
            Content = messageContent,
            Sender = "User",
            Timestamp = DateTime.Now
        };

        conversation.Messages.Add(message);
        await _context.SaveChangesAsync();
        return Ok();
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
}
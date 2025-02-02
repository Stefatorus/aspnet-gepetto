using Microsoft.AspNetCore.Identity;
using System.ComponentModel.DataAnnotations;

namespace GPTServer.Models;

public class Conversation
{
    [Key]
    public int Id { get; set; }
    public string UserId { get; set; }
    public IdentityUser User { get; set; }
    public string Title { get; set; }
    public List<Message> Messages { get; set; } = new List<Message>();
}
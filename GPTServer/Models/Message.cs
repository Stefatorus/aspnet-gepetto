using System.ComponentModel.DataAnnotations;

namespace GPTServer.Models;

public class Message
{
    [Key]
    public int Id { get; set; }
    public string Content { get; set; }
    public string Sender { get; set; }
    public DateTime Timestamp { get; set; }
}
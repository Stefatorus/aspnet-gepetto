namespace GPTServer.Models;

public class SendMessageRequest
{
    public int ConversationId { get; set; }
    public string MessageContent { get; set; }
    public string Model { get; set; }
}

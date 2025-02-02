namespace GPTServer.Models;

public class ChatViewModel
{
    public List<Conversation> Conversations { get; set; }
    public List<string> AvailableModels { get; set; }
}
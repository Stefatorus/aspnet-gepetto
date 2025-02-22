using System.Net.Http.Json;
using GPTAndroid.Models;

namespace GPTAndroid.Services;

public class ChatService
{
    private readonly HttpClient _httpClient;

    public ChatService(HttpClient httpClient)
    {
        _httpClient = httpClient;
    }

    public async Task<List<Message>> GetMessagesAsync(int conversationId)
    {
        try
        {
            return await _httpClient.GetFromJsonAsync<List<Message>>(
                $"api/ApiChat/messages?conversationId={conversationId}") ?? new List<Message>();
        }
        catch (Exception)
        {
            return new List<Message>();
        }
    }

    public async Task<MessageResponse> SendMessageAsync(int conversationId, string messageContent, string model)
    {
        try
        {
            var request = new SendMessageRequest
            {
                ConversationId = conversationId,
                MessageContent = messageContent,
                Model = model
            };

            var response = await _httpClient.PostAsJsonAsync("api/ApiChat/sendmessage", request);
            
            if (response.IsSuccessStatusCode)
            {
                return await response.Content.ReadFromJsonAsync<MessageResponse>();
            }
            
            return null;
        }
        catch (Exception)
        {
            return null;
        }
    }

    public async Task<Conversation> CreateConversationAsync()
    {
        try
        {
            return await _httpClient.GetFromJsonAsync<Conversation>("api/ApiChat/createconversation");
        }
        catch (Exception)
        {
            return null;
        }
    }
}

public class SendMessageRequest
{
    public int ConversationId { get; set; }
    public string MessageContent { get; set; }
    public string Model { get; set; }
}

public class MessageResponse
{
    public Message UserMessage { get; set; }
    public Message ResponseMessage { get; set; }
}

public class Message
{
    public string Sender { get; set; }
    public string Content { get; set; }
    public DateTime Timestamp { get; set; }
}

public class Conversation
{
    public int Id { get; set; }
    public string Title { get; set; }
    public List<Message> Messages { get; set; } = new();
}
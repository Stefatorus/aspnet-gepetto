using System.Collections.ObjectModel;
using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using GPTAndroid.Services;

namespace GPTAndroid.ViewModels;

public partial class ChatViewModel : ObservableObject
{
    private readonly ChatService _chatService;
    private int _conversationId;

    [ObservableProperty]
    private ObservableCollection<Message> _messages = new();

    [ObservableProperty]
    private string _newMessage;

    [ObservableProperty]
    private bool _isNotSending = true;

    public ChatViewModel(ChatService chatService)
    {
        _chatService = chatService;
    }

    public async void Initialize(int conversationId)
    {
        _conversationId = conversationId;
        await LoadMessages();
    }

    private async Task LoadMessages()
    {
        try
        {
            var messages = await _chatService.GetMessagesAsync(_conversationId);
            Messages = new ObservableCollection<Message>(messages);
        }
        catch (Exception ex)
        {
            await Application.Current.MainPage.DisplayAlert(
                "Error", 
                "Failed to load messages", 
                "OK");
        }
    }

    [RelayCommand]
    private async Task SendMessage()
    {
        if (string.IsNullOrWhiteSpace(NewMessage))
            return;

        IsNotSending = false;

        try
        {
            var response = await _chatService.SendMessageAsync(
                _conversationId,
                NewMessage,
                "claude-3-5-haiku-20241022"
            );

            if (response?.UserMessage != null)
            {
                Messages.Add(response.UserMessage);
                Messages.Add(response.ResponseMessage);
                NewMessage = string.Empty;
                
            }
        }
        catch (Exception ex)
        {
            await Application.Current.MainPage.DisplayAlert(
                "Error", 
                "Failed to send message", 
                "OK");
        }
        finally
        {
            IsNotSending = true;
        }
    }
}
using GPTAndroid.ViewModels;

namespace GPTAndroid.Pages;

public partial class ChatPage : ContentPage
{
    private readonly ChatViewModel _viewModel;

    public ChatPage(ChatViewModel viewModel)
    {
        InitializeComponent();
        _viewModel = viewModel;
        BindingContext = viewModel;
    }

    protected override void OnNavigatedTo(NavigatedToEventArgs args)
    {
        base.OnNavigatedTo(args);
        
        if (Shell.Current.CurrentState.Location.ToString() is string location &&
            location.Contains("?conversationId="))
        {
            var idString = location.Split("?conversationId=")[1];
            if (int.TryParse(idString, out int conversationId))
            {
                _viewModel.Initialize(conversationId);
            }
        }
    }
}
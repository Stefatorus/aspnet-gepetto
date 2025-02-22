using GPTAndroid.ViewModels;

namespace GPTAndroid.Pages;

public partial class ConversationsPage : ContentPage
{
    private readonly ConversationsViewModel _viewModel;

    public ConversationsPage(ConversationsViewModel viewModel)
    {
        InitializeComponent();
        BindingContext = viewModel;
        _viewModel = viewModel;
    }

    protected override async void OnAppearing()
    {
        base.OnAppearing();
        await _viewModel.LoadConversationsCommand.ExecuteAsync(null);
    }

    private async void OnConversationSelected(object sender, SelectedItemChangedEventArgs e)
    {
        if (e.SelectedItem is ConversationModel conversation)
            // Navigate to ChatPage with the selected conversation id.
            await Shell.Current.GoToAsync($"///{nameof(ChatPage)}?ConversationId={conversation.Id}");
    }
}
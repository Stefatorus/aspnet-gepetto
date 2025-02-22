using System.Collections.ObjectModel;
using System.Threading.Tasks;
using CommunityToolkit.Mvvm.Input;

namespace GPTAndroid.ViewModels
{
    public class ConversationsViewModel
    {
        public ConversationsViewModel()
        {
            Conversations = new ObservableCollection<ConversationModel>();
            LoadConversationsCommand = new AsyncRelayCommand(LoadConversationsAsync);
        }

        // Replace with real API calls as needed.
        public ObservableCollection<ConversationModel> Conversations { get; set; }
        public IAsyncRelayCommand LoadConversationsCommand { get; }

        public async Task LoadConversationsAsync()
        {
            Conversations.Clear();
            // Dummy data; replace with your API call for conversations.
            Conversations.Add(new ConversationModel { Id = 1, Title = "Conversation 1" });
            Conversations.Add(new ConversationModel { Id = 2, Title = "Conversation 2" });
            await Task.CompletedTask;
        }
    }

    public class ConversationModel
    {
        public int Id { get; set; }
        public string Title { get; set; }
    }
}
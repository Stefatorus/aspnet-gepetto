using System.ComponentModel;
using System.Runtime.CompilerServices;
using System.Windows.Input;
using CommunityToolkit.Mvvm.Input;
using GPTAndroid.Services;

namespace GPTAndroid.ViewModels;

public class LoginViewModel : INotifyPropertyChanged
{
    private readonly AuthService _authService;
    private bool _isBusy;
    private string _password;
    private string _username;

    public LoginViewModel(AuthService authService)
    {
        _authService = authService;
        LoginCommand = new AsyncRelayCommand(LoginAsync);
    }

    public string Username
    {
        get => _username;
        set
        {
            _username = value;
            OnPropertyChanged();
        }
    }

    public string Password
    {
        get => _password;
        set
        {
            _password = value;
            OnPropertyChanged();
        }
    }

    public bool IsBusy
    {
        get => _isBusy;
        set
        {
            _isBusy = value;
            OnPropertyChanged();
        }
    }

    public ICommand LoginCommand { get; }

    public event PropertyChangedEventHandler PropertyChanged;

    private async Task LoginAsync()
    {
        if (IsBusy)
            return;
        IsBusy = true;

        var success = await _authService.LoginAsync(Username, Password);
        if (success)
            // Navigate to Conversations Page on success
            await Shell.Current.GoToAsync("///ConversationsPage");

        // Handle error (show message, etc.)
        IsBusy = false;
    }

    protected void OnPropertyChanged([CallerMemberName] string propertyName = null)
    {
        PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
    }
}
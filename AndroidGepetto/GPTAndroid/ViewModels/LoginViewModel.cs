using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using GPTAndroid.Services;

namespace GPTAndroid.ViewModels;

public partial class LoginViewModel : ObservableObject
{
    private readonly AuthService _authService;

    [ObservableProperty]
    private string _email;

    [ObservableProperty]
    private string _password;

    [ObservableProperty]
    [NotifyPropertyChangedFor(nameof(IsNotBusy))]
    private bool _isBusy;

    public bool IsNotBusy => !IsBusy;

    public LoginViewModel(AuthService authService)
    {
        _authService = authService;
    }

    [RelayCommand(CanExecute = nameof(IsNotBusy))]
    private async Task LoginAsync()
    {
        if (string.IsNullOrWhiteSpace(Email) || string.IsNullOrWhiteSpace(Password))
        {
            await Application.Current.MainPage.DisplayAlert(
                "Error", 
                "Please enter both email and password", 
                "OK");
            return;
        }

        try
        {
            IsBusy = true;
            var success = await _authService.LoginAsync(Email, Password);
            
            if (success)
            {
                // Navigare către pagina de conversații
                await Shell.Current.GoToAsync("//ConversationsPage");
            }
            else
            {
                await Application.Current.MainPage.DisplayAlert(
                    "Error", 
                    "Invalid email or password", 
                    "OK");
            }
        }
        catch (Exception ex)
        {
            await Application.Current.MainPage.DisplayAlert(
                "Error",
                "An error occurred during login. Please try again.",
                "OK");
        }
        finally
        {
            IsBusy = false;
        }
    }

    [RelayCommand]
    private async Task NavigateToRegisterAsync()
    {
        await Shell.Current.GoToAsync("//RegisterPage");
    }
}
using GPTAndroid.Pages;
using GPTAndroid.Services;
using GPTAndroid.ViewModels;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Http;

namespace GPTAndroid;

public static class MauiProgram
{
    public static MauiApp CreateMauiApp()
    {
        var builder = MauiApp.CreateBuilder();
        builder
            .UseMauiApp<App>()
            .ConfigureFonts(fonts =>
            {
                fonts.AddFont("OpenSans-Regular.ttf", "OpenSansRegular");
                fonts.AddFont("OpenSans-Semibold.ttf", "OpenSansSemibold");
            });

        

        // Register HttpClient for API calls.
        var httpMessageHandler = new HttpClientHandler
        {
            ServerCertificateCustomValidationCallback = (message, cert, chain, errors) => true
        };

        // Register HttpClient for API calls with the custom handler
        builder.Services.AddHttpClient<AuthService>(client =>
        {
            client.BaseAddress = new Uri("https://10.0.2.2:44331/");
        }).ConfigurePrimaryHttpMessageHandler(() => httpMessageHandler);

        builder.Services.AddHttpClient<ChatService>(client =>
        {
            client.BaseAddress = new Uri("https://10.0.2.2:44331/");
        }).ConfigurePrimaryHttpMessageHandler(() => httpMessageHandler);

        
        // Register ViewModels
        builder.Services.AddSingleton<LoginViewModel>();
        builder.Services.AddSingleton<ConversationsViewModel>();
        builder.Services.AddSingleton<ChatViewModel>();

        // Register Pages
        builder.Services.AddSingleton<Pages.LoginPage>();
        builder.Services.AddSingleton<Pages.ConversationsPage>();
        builder.Services.AddSingleton<Pages.ChatPage>();


#if DEBUG
        builder.Logging.AddDebug();
#endif

        return builder.Build();
    }
}
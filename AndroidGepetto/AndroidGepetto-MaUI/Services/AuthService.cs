using System.Net.Http;
using System.Net.Http.Json;
using System.Threading.Tasks;

namespace AndroidGepetto.Services;

public class AuthService
{
    private readonly HttpClient _client;

    public AuthService(HttpClient client)
    {
        _client = client;
    }

    public async Task<bool> LoginAsync(string username, string password)
    {
        var loginData = new { Username = username, Password = password };
        var response = await _client.PostAsJsonAsync("api/auth/login", loginData);
        if (!response.IsSuccessStatusCode)
            return false;

        // If the server returns a JSON with a token, parse it:
        var result = await response.Content.ReadFromJsonAsync<LoginResponse>();
        // You could store the token in SecureStorage for future calls:
        // await SecureStorage.Default.SetAsync("jwt_token", result.Token);
        return true;
    }
}

public class LoginResponse
{
    public string Token { get; set; }
}
using System.Net.Http.Headers;
using System.Net.Http.Json;

namespace GPTAndroid.Services;

public class AuthService
{
    private readonly HttpClient _httpClient;
    private string _jwtToken;

    public AuthService(HttpClient httpClient)
    {
        _httpClient = httpClient;
    }

    public async Task<bool> LoginAsync(string email, string password)
    {
        var loginRequest = new
        {
            Email = email,
            Password = password
        };

        var response = await _httpClient.PostAsJsonAsync("api/ApiAuth/login", loginRequest);
        
        if (response.IsSuccessStatusCode)
        {
            var result = await response.Content.ReadFromJsonAsync<TokenResponse>();
            if (result?.Token != null)
            {
                _jwtToken = result.Token;
                // Setăm token-ul pentru toate request-urile viitoare
                _httpClient.DefaultRequestHeaders.Authorization = 
                    new AuthenticationHeaderValue("Bearer", _jwtToken);
                return true;
            }
        }
        return false;
    }

    public async Task<bool> RegisterAsync(string email, string password)
    {
        var registerRequest = new
        {
            Email = email,
            Password = password
        };

        var response = await _httpClient.PostAsJsonAsync("api/ApiAuth/register", registerRequest);
        
        if (response.IsSuccessStatusCode)
        {
            var result = await response.Content.ReadFromJsonAsync<TokenResponse>();
            if (result?.Token != null)
            {
                _jwtToken = result.Token;
                _httpClient.DefaultRequestHeaders.Authorization = 
                    new AuthenticationHeaderValue("Bearer", _jwtToken);
                return true;
            }
        }
        return false;
    }

    public void Logout()
    {
        _jwtToken = null;
        _httpClient.DefaultRequestHeaders.Authorization = null;
    }

    private class TokenResponse
    {
        public string Token { get; set; }
    }
}
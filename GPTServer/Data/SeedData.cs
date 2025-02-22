using Microsoft.AspNetCore.Identity;

namespace GPTServer.Data;

public static class SeedData
{
    public static async Task Initialize(IServiceProvider serviceProvider)
    {
        var roleManager = serviceProvider.GetRequiredService<RoleManager<IdentityRole>>();
        var userManager = serviceProvider.GetRequiredService<UserManager<IdentityUser>>();

        string[] roleNames = {"Claude-Sonnet", "User"};
        IdentityResult roleResult;

        foreach (var roleName in roleNames)
        {
            var roleExist = await roleManager.RoleExistsAsync(roleName);
            if (!roleExist) roleResult = await roleManager.CreateAsync(new IdentityRole(roleName));
        }

        // Generare user admin (cu acces sonnet)
        var adminUser = new IdentityUser
        {
            UserName = "sonnet@example.com",
            Email = "sonnet@example.com"
        };

        var adminPassword = "Sonnet123!";
        var user = await userManager.FindByEmailAsync("sonnet@example.com");

        // Doar la seeding initial
        if (user == null)
        {
            var createAdminUser = await userManager.CreateAsync(adminUser, adminPassword);
            if (createAdminUser.Succeeded) await userManager.AddToRoleAsync(adminUser, "Claude-Sonnet");
            // Set email as confirmed for pisat
            await userManager.ConfirmEmailAsync(adminUser,
                await userManager.GenerateEmailConfirmationTokenAsync(adminUser));
        }
    }
}
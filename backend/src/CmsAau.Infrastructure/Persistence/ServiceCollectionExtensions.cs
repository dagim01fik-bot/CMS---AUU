using CmsAau.Application.Common.Interfaces;
using CmsAau.Infrastructure.Authentication;
using CmsAau.Infrastructure.Data;
using CmsAau.Infrastructure.Security;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Configuration;

namespace CmsAau.Infrastructure.Persistence;

public static class ServiceCollectionExtensions
{
    public static IServiceCollection AddInfrastructureServices(this IServiceCollection services, IConfiguration configuration)
    {
        var useInMemoryDatabase = configuration.GetValue<bool>("Infrastructure:UseInMemoryDatabase");
        services.AddDbContext<ApplicationDbContext>(options =>
        {
            if (useInMemoryDatabase)
            {
                options.UseInMemoryDatabase("CmsAauDev");
                return;
            }

            options.UseNpgsql(configuration.GetConnectionString("DefaultConnection"));
        });

        services.AddScoped<IJwtTokenService, JwtTokenService>();
        services.AddScoped<IStudentAuthService, StudentAuthService>();
        services.AddScoped<ISecurityOfficerAuthService, SecurityOfficerAuthService>();
        services.AddScoped<IStudentIdCredentialService, StudentIdCredentialService>();
        services.AddScoped<IStudentIdVerificationService, StudentIdVerificationService>();
        services.AddScoped<PasswordHasherService>();
        services.AddScoped<DevelopmentIdentitySeeder>();

        return services;
    }
}

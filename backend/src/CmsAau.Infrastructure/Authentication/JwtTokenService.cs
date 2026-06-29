using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using CmsAau.Application.Common.Interfaces;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;

namespace CmsAau.Infrastructure.Authentication;

public sealed class JwtTokenService : IJwtTokenService
{
    private readonly IConfiguration _configuration;

    public JwtTokenService(IConfiguration configuration)
    {
        _configuration = configuration;
    }

    public string GenerateToken(Guid userId, string role, string displayName, string identifier)
    {
        var issuer = _configuration["Jwt:Issuer"] ?? "CmsAau";
        var audience = _configuration["Jwt:Audience"] ?? "CmsAauUsers";
        var secret = _configuration["Jwt:Secret"] ?? string.Empty;
        var expiryMinutes = _configuration.GetValue<int?>("Jwt:ExpiryInMinutes") ?? 15;

        var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(secret));
        var credentials = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);
        var claims = new List<Claim>
        {
            new(JwtRegisteredClaimNames.Sub, userId.ToString()),
            new(JwtRegisteredClaimNames.UniqueName, displayName),
            new("identifier", identifier),
            new(ClaimTypes.NameIdentifier, userId.ToString()),
            new(ClaimTypes.Role, role),
        };

        var token = new JwtSecurityToken(
            issuer: issuer,
            audience: audience,
            claims: claims,
            expires: DateTime.UtcNow.AddMinutes(expiryMinutes),
            signingCredentials: credentials);

        return new JwtSecurityTokenHandler().WriteToken(token);
    }
}

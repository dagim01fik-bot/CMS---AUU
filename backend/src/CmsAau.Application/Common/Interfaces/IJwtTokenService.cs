namespace CmsAau.Application.Common.Interfaces;

public interface IJwtTokenService
{
    string GenerateToken(Guid userId, string role, string displayName, string identifier);
}

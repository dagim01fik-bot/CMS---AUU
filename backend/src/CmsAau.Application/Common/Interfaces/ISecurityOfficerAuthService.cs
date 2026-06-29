using CmsAau.Application.Auth.Contracts;

namespace CmsAau.Application.Common.Interfaces;

public interface ISecurityOfficerAuthService
{
    Task<AuthResponse> LoginAsync(SecurityOfficerLoginRequest request, CancellationToken cancellationToken = default);
}

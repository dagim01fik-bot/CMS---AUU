using CmsAau.Application.Auth.Contracts;

namespace CmsAau.Application.Common.Interfaces;

public interface IStudentAuthService
{
    Task<AuthResponse> LoginAsync(StudentLoginRequest request, CancellationToken cancellationToken = default);
}

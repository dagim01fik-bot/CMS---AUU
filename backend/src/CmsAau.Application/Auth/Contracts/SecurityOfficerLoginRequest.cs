namespace CmsAau.Application.Auth.Contracts;

public sealed class SecurityOfficerLoginRequest
{
    public string Identifier { get; set; } = string.Empty;
    public string Password { get; set; } = string.Empty;
    public string InstallationId { get; set; } = string.Empty;
}

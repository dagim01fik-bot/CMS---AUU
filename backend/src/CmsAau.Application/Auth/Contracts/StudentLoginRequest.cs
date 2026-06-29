namespace CmsAau.Application.Auth.Contracts;

public sealed class StudentLoginRequest
{
    public string StudentId { get; set; } = string.Empty;
    public string Password { get; set; } = string.Empty;
}

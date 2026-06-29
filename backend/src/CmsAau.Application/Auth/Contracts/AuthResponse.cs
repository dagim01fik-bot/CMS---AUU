namespace CmsAau.Application.Auth.Contracts;

public sealed class AuthResponse
{
    public string AccessToken { get; set; } = string.Empty;
    public string Role { get; set; } = string.Empty;
    public AuthUserSummary User { get; set; } = new();
    public AuthCheckpointSummary? Checkpoint { get; set; }
}

public sealed class AuthUserSummary
{
    public Guid Id { get; set; }
    public string FullName { get; set; } = string.Empty;
    public string BadgeNumber { get; set; } = string.Empty;
    public string StudentId { get; set; } = string.Empty;
}

public sealed class AuthCheckpointSummary
{
    public string DeviceTag { get; set; } = string.Empty;
    public string Name { get; set; } = string.Empty;
}

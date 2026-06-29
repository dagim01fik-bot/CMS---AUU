namespace CmsAau.Api.Options;

public sealed class SecurityVerificationOptions
{
    public const string SectionName = "SecurityVerification";

    public string OpaqueTokenSecret { get; set; } = string.Empty;
    public int ResultDisplaySeconds { get; set; } = 8;
}

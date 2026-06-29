namespace CmsAau.Application.Verification.Contracts;

public sealed class VerifyStudentIdRequest
{
    public string OpaqueToken { get; set; } = string.Empty;
    public string DeviceTag { get; set; } = string.Empty;
}

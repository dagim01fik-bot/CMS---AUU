namespace CmsAau.Application.Verification.Contracts;

public static class VerificationFailureCode
{
    public const string InvalidToken = "invalid_token";
    public const string DeviceMismatch = "device_mismatch";
    public const string CredentialInactive = "credential_inactive";
    public const string StudentInactive = "student_inactive";
    public const string StudentSuspended = "student_suspended";
}

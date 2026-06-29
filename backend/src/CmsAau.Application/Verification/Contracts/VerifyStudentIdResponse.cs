namespace CmsAau.Application.Verification.Contracts;

public sealed class VerifyStudentIdResponse
{
    public string StudentName { get; set; } = string.Empty;
    public string StudentId { get; set; } = string.Empty;
    public string Program { get; set; } = string.Empty;
    public int YearOfStudy { get; set; }
    public string EnrollmentStatus { get; set; } = string.Empty;
    public string AcademicYear { get; set; } = string.Empty;
    public string? PhotoThumbnailUrl { get; set; }
    public DateTime VerifiedAtUtc { get; set; }
    public string Source { get; set; } = "online";
    public string? WarningMessage { get; set; }
}

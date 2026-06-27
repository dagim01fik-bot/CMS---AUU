namespace CmsAau.Domain.Entities;

public class Attendance
{
    public Guid Id { get; set; }
    public Guid StudentId { get; set; }
    public Student Student { get; set; } = null!;
    public Guid AttendanceSessionId { get; set; }
    public AttendanceSession AttendanceSession { get; set; } = null!;
    public DateTime CheckInTime { get; set; } = DateTime.UtcNow;
    public string Status { get; set; } = "Present";
    public double? ConfidenceScore { get; set; }
    public string? VerificationMethod { get; set; }
}
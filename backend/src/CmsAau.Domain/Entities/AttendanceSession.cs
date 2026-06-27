namespace CmsAau.Domain.Entities;

public class AttendanceSession
{
    public Guid Id { get; set; }
    public Guid CourseId { get; set; }
    public Course Course { get; set; } = null!;
    public Guid InstructorId { get; set; }
    public Instructor Instructor { get; set; } = null!;
    public DateTime SessionDate { get; set; } = DateTime.UtcNow;
    public DateTime? StartTime { get; set; }
    public DateTime? EndTime { get; set; }
    public string SessionCode { get; set; } = string.Empty;
    public string Status { get; set; } = "Scheduled";
    public ICollection<Attendance> Attendances { get; set; } = new List<Attendance>();
}
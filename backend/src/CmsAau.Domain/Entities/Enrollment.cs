namespace CmsAau.Domain.Entities;

public class Enrollment
{
    public Guid Id { get; set; }
    public Guid StudentId { get; set; }
    public Student Student { get; set; } = null!;
    public Guid CourseId { get; set; }
    public Course Course { get; set; } = null!;
    public DateTime EnrollmentDate { get; set; } = DateTime.UtcNow;
    public string Status { get; set; } = "Enrolled";
    public string? Grade { get; set; }
    public ICollection<Attendance> Attendances { get; set; } = new List<Attendance>();
}
namespace CmsAau.Domain.Entities;

public class Schedule
{
    public Guid Id { get; set; }
    public Guid CourseId { get; set; }
    public Course Course { get; set; } = null!;
    public DayOfWeek DayOfWeek { get; set; }
    public TimeSpan StartTime { get; set; }
    public TimeSpan EndTime { get; set; }
    public string Location { get; set; } = string.Empty;
    public string Semester { get; set; } = string.Empty;
    public string AcademicYear { get; set; } = string.Empty;
}
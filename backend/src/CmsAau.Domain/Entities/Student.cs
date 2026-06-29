namespace CmsAau.Domain.Entities;

public class Student : User
{
    public string StudentId { get; set; } = string.Empty;
    public DateTime DateOfBirth { get; set; }
    public string Gender { get; set; } = string.Empty;
    public string Address { get; set; } = string.Empty;
    public string? ProfilePictureUrl { get; set; }
    public Guid DepartmentId { get; set; }
    public Department Department { get; set; } = null!;
    public int YearOfStudy { get; set; }
    public string AcademicStatus { get; set; } = "Active";
    public ICollection<StudentIdCredential> StudentIdCredentials { get; set; } = new List<StudentIdCredential>();
    public ICollection<Enrollment> Enrollments { get; set; } = new List<Enrollment>();
    public ICollection<Attendance> Attendances { get; set; } = new List<Attendance>();
    public ICollection<Grade> Grades { get; set; } = new List<Grade>();
    public ICollection<Invoice> Invoices { get; set; } = new List<Invoice>();
}

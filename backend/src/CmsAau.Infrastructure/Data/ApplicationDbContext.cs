using CmsAau.Domain.Entities;
using Microsoft.EntityFrameworkCore;

namespace CmsAau.Infrastructure.Data;

public class ApplicationDbContext : DbContext
{
    public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
        : base(options)
    {
    }

    public DbSet<Student> Students { get; set; }
    public DbSet<Instructor> Instructors { get; set; }
    public DbSet<Department> Departments { get; set; }
    public DbSet<Course> Courses { get; set; }
    public DbSet<Enrollment> Enrollments { get; set; }
    public DbSet<Schedule> Schedules { get; set; }
    public DbSet<AttendanceSession> AttendanceSessions { get; set; }
    public DbSet<Attendance> Attendances { get; set; }
    public DbSet<Invoice> Invoices { get; set; }
    public DbSet<Payment> Payments { get; set; }
    public DbSet<Grade> Grades { get; set; }
    public DbSet<AuditLog> AuditLogs { get; set; }
    public DbSet<SecurityOfficer> SecurityOfficers { get; set; }
    public DbSet<SecurityCheckpointDevice> SecurityCheckpointDevices { get; set; }
    public DbSet<StudentIdCredential> StudentIdCredentials { get; set; }
    public DbSet<SecurityScanLog> SecurityScanLogs { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        modelBuilder.Entity<User>()
            .UseTptMappingStrategy();

        modelBuilder.Entity<Department>()
            .HasIndex(d => d.Code)
            .IsUnique();

        modelBuilder.Entity<Student>()
            .HasIndex(s => s.StudentId)
            .IsUnique();

        modelBuilder.Entity<Student>()
            .HasIndex(s => s.Email)
            .IsUnique();

        modelBuilder.Entity<Instructor>()
            .HasIndex(i => i.EmployeeId)
            .IsUnique();

        modelBuilder.Entity<Instructor>()
            .HasIndex(i => i.Email)
            .IsUnique();

        modelBuilder.Entity<SecurityOfficer>()
            .HasIndex(o => o.BadgeNumber)
            .IsUnique();

        modelBuilder.Entity<SecurityOfficer>()
            .HasIndex(o => o.Email)
            .IsUnique();

        modelBuilder.Entity<Course>()
            .HasIndex(c => c.Code)
            .IsUnique();

        modelBuilder.Entity<Invoice>()
            .HasIndex(i => i.InvoiceNumber)
            .IsUnique();

        modelBuilder.Entity<SecurityCheckpointDevice>()
            .HasIndex(d => d.DeviceTag)
            .IsUnique();

        modelBuilder.Entity<SecurityCheckpointDevice>()
            .HasIndex(d => d.InstallationId)
            .IsUnique();

        modelBuilder.Entity<StudentIdCredential>()
            .HasIndex(c => c.OpaqueTokenHash)
            .IsUnique();

        modelBuilder.Entity<StudentIdCredential>()
            .HasOne(c => c.Student)
            .WithMany(s => s.StudentIdCredentials)
            .HasForeignKey(c => c.StudentRecordId)
            .OnDelete(DeleteBehavior.Cascade);

        modelBuilder.Entity<SecurityScanLog>()
            .HasOne(l => l.Student)
            .WithMany()
            .HasForeignKey(l => l.StudentRecordId)
            .OnDelete(DeleteBehavior.SetNull);

        modelBuilder.Entity<SecurityScanLog>()
            .HasOne(l => l.SecurityOfficer)
            .WithMany(o => o.ScanLogs)
            .HasForeignKey(l => l.SecurityOfficerId)
            .OnDelete(DeleteBehavior.Restrict);

        modelBuilder.Entity<SecurityScanLog>()
            .HasOne(l => l.SecurityCheckpointDevice)
            .WithMany(d => d.ScanLogs)
            .HasForeignKey(l => l.SecurityCheckpointDeviceId)
            .OnDelete(DeleteBehavior.Restrict);
    }
}

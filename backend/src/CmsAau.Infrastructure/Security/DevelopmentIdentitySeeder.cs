using CmsAau.Domain.Entities;
using CmsAau.Infrastructure.Authentication;
using CmsAau.Infrastructure.Data;
using Microsoft.EntityFrameworkCore;

namespace CmsAau.Infrastructure.Security;

public sealed class DevelopmentIdentitySeeder
{
    private readonly ApplicationDbContext _dbContext;
    private readonly PasswordHasherService _passwordHasher;

    public DevelopmentIdentitySeeder(
        ApplicationDbContext dbContext,
        PasswordHasherService passwordHasher)
    {
        _dbContext = dbContext;
        _passwordHasher = passwordHasher;
    }

    public async Task SeedAsync(CancellationToken cancellationToken = default)
    {
        await SeedOfficerAsync(cancellationToken);
        await SeedStudentAsync(cancellationToken);
    }

    private async Task SeedOfficerAsync(CancellationToken cancellationToken)
    {
        var officer = await _dbContext.SecurityOfficers
            .FirstOrDefaultAsync(o => o.BadgeNumber == "SEC-0042", cancellationToken);

        if (officer is null)
        {
            officer = new SecurityOfficer
            {
                Id = Guid.NewGuid(),
                FirstName = "Samuel",
                LastName = "Tesfaye",
                Email = "samuel.tesfaye@unigate.local",
                BadgeNumber = "SEC-0042",
                PasswordHash = _passwordHasher.HashPassword("officer@44"),
                PhoneNumber = "0911222333",
                IsActive = true,
                CreatedAt = DateTime.UtcNow,
            };
            _dbContext.SecurityOfficers.Add(officer);
        }
        else
        {
            officer.PasswordHash = _passwordHasher.HashPassword("officer@44");
            officer.IsActive = true;
            officer.UpdatedAt = DateTime.UtcNow;
        }

        await _dbContext.SaveChangesAsync(cancellationToken);
    }

    private async Task SeedStudentAsync(CancellationToken cancellationToken)
    {
        var department = await _dbContext.Departments
            .FirstOrDefaultAsync(d => d.Code == "CS", cancellationToken);

        if (department is null)
        {
            department = new Department
            {
                Id = Guid.NewGuid(),
                Name = "Computer Science",
                Code = "CS",
                Description = "Department of Computer Science",
                CreatedAt = DateTime.UtcNow,
            };
            _dbContext.Departments.Add(department);
            await _dbContext.SaveChangesAsync(cancellationToken);
        }

        var student = await _dbContext.Students
            .FirstOrDefaultAsync(s => s.StudentId == "STU-ET-00918372", cancellationToken);

        if (student is null)
        {
            student = new Student
            {
                Id = Guid.NewGuid(),
                FirstName = "Mekdes",
                LastName = "Alemu",
                Email = "mekdes.alemu@unigate.local",
                PasswordHash = _passwordHasher.HashPassword("student-pass"),
                PhoneNumber = "0911000000",
                IsActive = true,
                StudentId = "STU-ET-00918372",
                DateOfBirth = new DateTime(2003, 4, 12),
                Gender = "Male",
                Address = "Hawassa",
                DepartmentId = department.Id,
                YearOfStudy = 3,
                AcademicStatus = "Active",
                ProfilePictureUrl = "https://example.com/mekdes-thumb.jpg",
                CreatedAt = DateTime.UtcNow,
            };
            _dbContext.Students.Add(student);
        }
        else
        {
            student.FirstName = "Mekdes";
            student.LastName = "Alemu";
            student.Email = "mekdes.alemu@unigate.local";
            student.PasswordHash = _passwordHasher.HashPassword("student-pass");
            student.IsActive = true;
            student.DepartmentId = department.Id;
            student.YearOfStudy = 3;
            student.AcademicStatus = "Active";
            student.ProfilePictureUrl = "https://example.com/mekdes-thumb.jpg";
            student.UpdatedAt = DateTime.UtcNow;
        }

        await _dbContext.SaveChangesAsync(cancellationToken);
    }
}

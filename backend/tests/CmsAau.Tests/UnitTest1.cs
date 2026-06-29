using System.Reflection;
using CmsAau.Application.Auth.Contracts;
using CmsAau.Application.Common.Interfaces;
using CmsAau.Application.Verification.Contracts;
using CmsAau.Domain.Entities;
using CmsAau.Infrastructure.Authentication;
using CmsAau.Infrastructure.Data;
using CmsAau.Infrastructure.Security;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;

namespace CmsAau.Tests;

public class SecurityFeatureTests
{
    [Fact]
    public async Task StudentIdCredentialService_PersistsHashedToken_NotPlaintext()
    {
        await using var fixture = await TestFixture.CreateAsync();
        var service = fixture.CreateCredentialService();

        var result = await service.GetOrCreateQrAsync(fixture.Student.Id);
        var persisted = await fixture.DbContext.StudentIdCredentials.SingleAsync();

        Assert.NotEqual(result.OpaqueToken, persisted.OpaqueTokenHash);
        Assert.Equal(StudentIdCredentialService.ComputeHash(result.OpaqueToken), persisted.OpaqueTokenHash);
    }

    [Fact]
    public async Task SecurityOfficerLogin_Fails_WhenDeviceAssignmentIsMissing()
    {
        await using var fixture = await TestFixture.CreateAsync(includeAssignedDevice: false);
        var service = fixture.CreateSecurityOfficerAuthService();

        await Assert.ThrowsAsync<InvalidOperationException>(() =>
            service.LoginAsync(new SecurityOfficerLoginRequest
            {
                Identifier = fixture.Officer.BadgeNumber,
                Password = TestFixture.OfficerPassword,
                InstallationId = TestFixture.InstallationId,
            }));
    }

    [Fact]
    public async Task Verification_Succeeds_AndWritesScanLog()
    {
        await using var fixture = await TestFixture.CreateAsync();
        var credentialService = fixture.CreateCredentialService();
        var verifyService = fixture.CreateVerificationService();
        var qr = await credentialService.GetOrCreateQrAsync(fixture.Student.Id);

        var response = await verifyService.VerifyAsync(
            fixture.Officer.Id,
            new VerifyStudentIdRequest
            {
                OpaqueToken = qr.OpaqueToken,
                DeviceTag = fixture.Device.DeviceTag,
            });

        Assert.Equal(fixture.Student.StudentId, response.StudentId);
        Assert.Equal(fixture.Department.Name, response.Program);
        Assert.Equal("online", response.Source);
        Assert.Equal(1, await fixture.DbContext.SecurityScanLogs.CountAsync());
    }

    [Fact]
    public void VerificationResponse_ContainsOnlyAllowlistedFields()
    {
        var propertyNames = typeof(VerifyStudentIdResponse)
            .GetProperties(BindingFlags.Public | BindingFlags.Instance)
            .Select(property => property.Name)
            .ToHashSet(StringComparer.OrdinalIgnoreCase);

        Assert.DoesNotContain("Gpa", propertyNames);
        Assert.DoesNotContain("Grades", propertyNames);
        Assert.DoesNotContain("FinancialStatus", propertyNames);
        Assert.DoesNotContain("MedicalInfo", propertyNames);
        Assert.Contains("StudentName", propertyNames);
        Assert.Contains("StudentId", propertyNames);
        Assert.Contains("Program", propertyNames);
    }
}

internal sealed class TestFixture : IAsyncDisposable
{
    public const string StudentPassword = "student-pass";
    public const string OfficerPassword = "officer@44";
    public const string InstallationId = "installation-01";

    private TestFixture(ApplicationDbContext dbContext, IConfiguration configuration)
    {
        DbContext = dbContext;
        Configuration = configuration;
    }

    public ApplicationDbContext DbContext { get; }
    public IConfiguration Configuration { get; }
    public Department Department { get; private set; } = null!;
    public Student Student { get; private set; } = null!;
    public SecurityOfficer Officer { get; private set; } = null!;
    public SecurityCheckpointDevice Device { get; private set; } = null!;

    public static async Task<TestFixture> CreateAsync(bool includeAssignedDevice = true)
    {
        var configuration = new ConfigurationBuilder()
            .AddInMemoryCollection(new Dictionary<string, string?>
            {
                ["Jwt:Issuer"] = "CmsAau",
                ["Jwt:Audience"] = "CmsAauUsers",
                ["Jwt:Secret"] = "CmsAau.Dev.Security.Secret.For.Jwt.2026",
                ["Jwt:ExpiryInMinutes"] = "15",
                ["SecurityVerification:OpaqueTokenSecret"] = "CmsAau.Dev.Student.Id.Token.Secret.2026",
            })
            .Build();

        var options = new DbContextOptionsBuilder<ApplicationDbContext>()
            .UseInMemoryDatabase(Guid.NewGuid().ToString("N"))
            .Options;

        var dbContext = new ApplicationDbContext(options);
        var fixture = new TestFixture(dbContext, configuration);
        await fixture.SeedAsync(includeAssignedDevice);
        return fixture;
    }

    public StudentIdCredentialService CreateCredentialService()
    {
        return new StudentIdCredentialService(DbContext, Configuration);
    }

    public SecurityOfficerAuthService CreateSecurityOfficerAuthService()
    {
        return new SecurityOfficerAuthService(
            DbContext,
            new JwtTokenService(Configuration),
            new PasswordHasherService(),
            Configuration);
    }

    public StudentIdVerificationService CreateVerificationService()
    {
        return new StudentIdVerificationService(DbContext);
    }

    public async ValueTask DisposeAsync()
    {
        await DbContext.DisposeAsync();
    }

    private async Task SeedAsync(bool includeAssignedDevice)
    {
        var passwordHasher = new PasswordHasherService();
        Department = new Department
        {
            Id = Guid.NewGuid(),
            Name = "Computer Science",
            Code = "CS",
            Description = "Department of Computer Science",
            CreatedAt = DateTime.UtcNow,
        };

        Student = new Student
        {
            Id = Guid.NewGuid(),
            FirstName = "Dawit",
            LastName = "Bekele",
            Email = "dawit@example.com",
            PasswordHash = passwordHasher.HashPassword(StudentPassword),
            PhoneNumber = "0911000000",
            IsActive = true,
            StudentId = "ETH-2024-00847",
            DateOfBirth = new DateTime(2003, 4, 12),
            Gender = "Male",
            Address = "Hawassa",
            DepartmentId = Department.Id,
            Department = Department,
            YearOfStudy = 3,
            AcademicStatus = "Active",
            ProfilePictureUrl = "https://example.com/thumb.jpg",
        };

        Officer = new SecurityOfficer
        {
            Id = Guid.NewGuid(),
            FirstName = "Samuel",
            LastName = "Tesfaye",
            Email = "samuel.tesfaye@example.com",
            PasswordHash = passwordHasher.HashPassword(OfficerPassword),
            PhoneNumber = "0911222333",
            IsActive = true,
            BadgeNumber = "SEC-0042",
        };

        Device = new SecurityCheckpointDevice
        {
            Id = Guid.NewGuid(),
            DeviceTag = "gate-a-east-01",
            CheckpointName = "Main Gate A - East Lane",
            InstallationId = InstallationId,
            Description = "Primary east entrance lane",
            IsActive = true,
        };

        DbContext.Departments.Add(Department);
        DbContext.Students.Add(Student);
        DbContext.SecurityOfficers.Add(Officer);
        if (includeAssignedDevice)
        {
            DbContext.SecurityCheckpointDevices.Add(Device);
        }

        await DbContext.SaveChangesAsync();
    }
}

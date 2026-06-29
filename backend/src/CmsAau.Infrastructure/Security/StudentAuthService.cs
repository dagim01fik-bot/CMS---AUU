using CmsAau.Application.Auth.Contracts;
using CmsAau.Application.Common.Interfaces;
using CmsAau.Infrastructure.Authentication;
using CmsAau.Infrastructure.Data;
using Microsoft.EntityFrameworkCore;

namespace CmsAau.Infrastructure.Security;

public sealed class StudentAuthService : IStudentAuthService
{
    private readonly ApplicationDbContext _dbContext;
    private readonly IJwtTokenService _jwtTokenService;
    private readonly PasswordHasherService _passwordHasher;

    public StudentAuthService(
        ApplicationDbContext dbContext,
        IJwtTokenService jwtTokenService,
        PasswordHasherService passwordHasher)
    {
        _dbContext = dbContext;
        _jwtTokenService = jwtTokenService;
        _passwordHasher = passwordHasher;
    }

    public async Task<AuthResponse> LoginAsync(StudentLoginRequest request, CancellationToken cancellationToken = default)
    {
        var student = await _dbContext.Students
            .FirstOrDefaultAsync(s => s.StudentId == request.StudentId, cancellationToken);

        if (student is null || !_passwordHasher.Verify(request.Password, student.PasswordHash))
        {
            throw new UnauthorizedAccessException("Invalid student credentials.");
        }

        if (!student.IsActive)
        {
            throw new InvalidOperationException("Student account is inactive.");
        }

        return new AuthResponse
        {
            AccessToken = _jwtTokenService.GenerateToken(student.Id, "student", $"{student.FirstName} {student.LastName}", student.StudentId),
            Role = "student",
            User = new AuthUserSummary
            {
                Id = student.Id,
                FullName = $"{student.FirstName} {student.LastName}",
                StudentId = student.StudentId,
            },
        };
    }
}

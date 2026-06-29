using System.Security.Cryptography;
using System.Text;
using CmsAau.Application.Common.Interfaces;
using CmsAau.Application.StudentId.Contracts;
using CmsAau.Domain.Entities;
using CmsAau.Infrastructure.Data;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;

namespace CmsAau.Infrastructure.Security;

public sealed class StudentIdCredentialService : IStudentIdCredentialService
{
    private readonly ApplicationDbContext _dbContext;
    private readonly IConfiguration _configuration;

    public StudentIdCredentialService(ApplicationDbContext dbContext, IConfiguration configuration)
    {
        _dbContext = dbContext;
        _configuration = configuration;
    }

    public async Task<StudentIdQrResponse> GetOrCreateQrAsync(Guid studentRecordId, CancellationToken cancellationToken = default)
    {
        var student = await _dbContext.Students
            .FirstOrDefaultAsync(s => s.Id == studentRecordId, cancellationToken);

        if (student is null)
        {
            throw new InvalidOperationException("Student record was not found.");
        }

        var opaqueToken = BuildOpaqueToken(student.Id);
        var tokenHash = ComputeHash(opaqueToken);

        var credential = await _dbContext.StudentIdCredentials
            .FirstOrDefaultAsync(c => c.StudentRecordId == student.Id && c.IsActive, cancellationToken);

        if (credential is null)
        {
            credential = new StudentIdCredential
            {
                StudentRecordId = student.Id,
                OpaqueTokenHash = tokenHash,
                IssuedAtUtc = DateTime.UtcNow,
                IsActive = true,
            };
            _dbContext.StudentIdCredentials.Add(credential);
            await _dbContext.SaveChangesAsync(cancellationToken);
        }
        else if (!string.Equals(credential.OpaqueTokenHash, tokenHash, StringComparison.Ordinal))
        {
            credential.OpaqueTokenHash = tokenHash;
            credential.IssuedAtUtc = DateTime.UtcNow;
            await _dbContext.SaveChangesAsync(cancellationToken);
        }

        return new StudentIdQrResponse
        {
            OpaqueToken = opaqueToken,
            StudentId = student.StudentId,
            DisplayName = $"{student.FirstName} {student.LastName}",
        };
    }

    internal string BuildOpaqueToken(Guid studentRecordId)
    {
        var secret = _configuration["SecurityVerification:OpaqueTokenSecret"];
        if (string.IsNullOrWhiteSpace(secret))
        {
            throw new InvalidOperationException("Security verification secret is not configured.");
        }

        using var hmac = new HMACSHA256(Encoding.UTF8.GetBytes(secret));
        var bytes = hmac.ComputeHash(Encoding.UTF8.GetBytes(studentRecordId.ToString("N")));
        return $"stu_{Convert.ToHexString(bytes)[..32]}";
    }

    public static string ComputeHash(string opaqueToken)
    {
        var bytes = SHA256.HashData(Encoding.UTF8.GetBytes(opaqueToken));
        return Convert.ToHexString(bytes);
    }
}

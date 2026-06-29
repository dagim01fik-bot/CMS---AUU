using CmsAau.Application.Common.Interfaces;
using CmsAau.Application.Verification.Contracts;
using CmsAau.Domain.Entities;
using CmsAau.Infrastructure.Data;
using Microsoft.EntityFrameworkCore;

namespace CmsAau.Infrastructure.Security;

public sealed class StudentIdVerificationService : IStudentIdVerificationService
{
    private readonly ApplicationDbContext _dbContext;

    public StudentIdVerificationService(ApplicationDbContext dbContext)
    {
        _dbContext = dbContext;
    }

    public async Task<VerifyStudentIdResponse> VerifyAsync(
        Guid officerId,
        VerifyStudentIdRequest request,
        CancellationToken cancellationToken = default)
    {
        var officer = await _dbContext.SecurityOfficers
            .FirstOrDefaultAsync(o => o.Id == officerId && o.IsActive, cancellationToken);
        if (officer is null)
        {
            throw new UnauthorizedAccessException("Officer account is invalid.");
        }

        var checkpoint = await _dbContext.SecurityCheckpointDevices
            .FirstOrDefaultAsync(d => d.DeviceTag == request.DeviceTag && d.IsActive, cancellationToken);
        if (checkpoint is null)
        {
            throw new InvalidOperationException(VerificationFailureCode.DeviceMismatch);
        }

        var tokenHash = StudentIdCredentialService.ComputeHash(request.OpaqueToken);
        var credential = await _dbContext.StudentIdCredentials
            .Include(c => c.Student)
            .ThenInclude(s => s.Department)
            .FirstOrDefaultAsync(c => c.OpaqueTokenHash == tokenHash, cancellationToken);

        if (credential is null)
        {
            await LogAsync(officer.Id, checkpoint.Id, null, "denied", VerificationFailureCode.InvalidToken, cancellationToken);
            throw new KeyNotFoundException(VerificationFailureCode.InvalidToken);
        }

        if (!credential.IsActive || credential.RevokedAtUtc is not null)
        {
            await LogAsync(officer.Id, checkpoint.Id, credential.StudentRecordId, "denied", VerificationFailureCode.CredentialInactive, cancellationToken);
            throw new InvalidOperationException(VerificationFailureCode.CredentialInactive);
        }

        var student = credential.Student;
        if (!student.IsActive)
        {
            await LogAsync(officer.Id, checkpoint.Id, student.Id, "denied", VerificationFailureCode.StudentInactive, cancellationToken);
            throw new InvalidOperationException(VerificationFailureCode.StudentInactive);
        }

        if (student.AcademicStatus.Contains("suspend", StringComparison.OrdinalIgnoreCase))
        {
            await LogAsync(officer.Id, checkpoint.Id, student.Id, "denied", VerificationFailureCode.StudentSuspended, cancellationToken);
            throw new InvalidOperationException(VerificationFailureCode.StudentSuspended);
        }

        var verifiedAt = DateTime.UtcNow;
        await LogAsync(officer.Id, checkpoint.Id, student.Id, "verified", string.Empty, cancellationToken);

        return new VerifyStudentIdResponse
        {
            StudentName = $"{student.FirstName} {student.LastName}",
            StudentId = student.StudentId,
            Program = student.Department.Name,
            YearOfStudy = student.YearOfStudy,
            EnrollmentStatus = $"{student.AcademicStatus} enrolled student",
            AcademicYear = BuildAcademicYear(verifiedAt),
            PhotoThumbnailUrl = student.ProfilePictureUrl,
            VerifiedAtUtc = verifiedAt,
            Source = "online",
        };
    }

    private async Task LogAsync(
        Guid officerId,
        Guid checkpointDeviceId,
        Guid? studentRecordId,
        string outcome,
        string failureReasonCode,
        CancellationToken cancellationToken)
    {
        _dbContext.SecurityScanLogs.Add(new SecurityScanLog
        {
            StudentRecordId = studentRecordId,
            SecurityOfficerId = officerId,
            SecurityCheckpointDeviceId = checkpointDeviceId,
            Outcome = outcome,
            Source = "online",
            FailureReasonCode = failureReasonCode,
            ScannedAtUtc = DateTime.UtcNow,
        });
        await _dbContext.SaveChangesAsync(cancellationToken);
    }

    private static string BuildAcademicYear(DateTime utcNow)
    {
        var local = utcNow.ToLocalTime();
        var startYear = local.Month >= 7 ? local.Year : local.Year - 1;
        var endYearSuffix = ((startYear + 1) % 100).ToString("D2");
        return $"{startYear}/{endYearSuffix}";
    }
}

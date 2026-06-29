using CmsAau.Application.Auth.Contracts;
using CmsAau.Application.Common.Interfaces;
using CmsAau.Domain.Entities;
using CmsAau.Infrastructure.Authentication;
using CmsAau.Infrastructure.Data;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;

namespace CmsAau.Infrastructure.Security;

public sealed class SecurityOfficerAuthService : ISecurityOfficerAuthService
{
    private readonly ApplicationDbContext _dbContext;
    private readonly IJwtTokenService _jwtTokenService;
    private readonly PasswordHasherService _passwordHasher;
    private readonly IConfiguration _configuration;

    public SecurityOfficerAuthService(
        ApplicationDbContext dbContext,
        IJwtTokenService jwtTokenService,
        PasswordHasherService passwordHasher,
        IConfiguration configuration)
    {
        _dbContext = dbContext;
        _jwtTokenService = jwtTokenService;
        _passwordHasher = passwordHasher;
        _configuration = configuration;
    }

    public async Task<AuthResponse> LoginAsync(SecurityOfficerLoginRequest request, CancellationToken cancellationToken = default)
    {
        var officer = await _dbContext.SecurityOfficers
            .FirstOrDefaultAsync(
                o => o.BadgeNumber == request.Identifier || o.Email == request.Identifier,
                cancellationToken);

        if (officer is null || !_passwordHasher.Verify(request.Password, officer.PasswordHash))
        {
            throw new UnauthorizedAccessException("Invalid officer credentials.");
        }

        if (!officer.IsActive)
        {
            throw new InvalidOperationException("Officer account is inactive.");
        }

        var checkpoint = await _dbContext.SecurityCheckpointDevices
            .FirstOrDefaultAsync(
                d => d.InstallationId == request.InstallationId && d.IsActive,
                cancellationToken);

        if (checkpoint is null)
        {
            if (!_configuration.GetValue<bool>("SecurityVerification:AllowAutoAssignCheckpointOnLogin"))
            {
                throw new InvalidOperationException("This device is not assigned to a checkpoint.");
            }

            checkpoint = new SecurityCheckpointDevice
            {
                Id = Guid.NewGuid(),
                DeviceTag = BuildDeviceTag(request.InstallationId),
                CheckpointName = "Auto Assigned Security Checkpoint",
                InstallationId = request.InstallationId,
                Description = "Development checkpoint auto-assigned during officer sign-in.",
                IsActive = true,
                LastSeenAtUtc = DateTime.UtcNow,
            };
            _dbContext.SecurityCheckpointDevices.Add(checkpoint);
            await _dbContext.SaveChangesAsync(cancellationToken);
        }

        checkpoint.LastSeenAtUtc = DateTime.UtcNow;
        await _dbContext.SaveChangesAsync(cancellationToken);

        return new AuthResponse
        {
            AccessToken = _jwtTokenService.GenerateToken(officer.Id, "security_officer", $"{officer.FirstName} {officer.LastName}", officer.BadgeNumber),
            Role = "security_officer",
            User = new AuthUserSummary
            {
                Id = officer.Id,
                FullName = $"{officer.FirstName} {officer.LastName}",
                BadgeNumber = officer.BadgeNumber,
            },
            Checkpoint = new AuthCheckpointSummary
            {
                DeviceTag = checkpoint.DeviceTag,
                Name = checkpoint.CheckpointName,
            },
        };
    }

    private static string BuildDeviceTag(string installationId)
    {
        var suffix = installationId.Length <= 8
            ? installationId
            : installationId[^8..];
        return $"auto-{suffix.ToLowerInvariant()}";
    }
}

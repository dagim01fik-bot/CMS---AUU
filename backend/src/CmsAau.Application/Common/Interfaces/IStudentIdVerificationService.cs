using CmsAau.Application.Verification.Contracts;

namespace CmsAau.Application.Common.Interfaces;

public interface IStudentIdVerificationService
{
    Task<VerifyStudentIdResponse> VerifyAsync(
        Guid officerId,
        VerifyStudentIdRequest request,
        CancellationToken cancellationToken = default);
}

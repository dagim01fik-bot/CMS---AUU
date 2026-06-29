using CmsAau.Application.StudentId.Contracts;

namespace CmsAau.Application.Common.Interfaces;

public interface IStudentIdCredentialService
{
    Task<StudentIdQrResponse> GetOrCreateQrAsync(Guid studentRecordId, CancellationToken cancellationToken = default);
}

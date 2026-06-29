namespace CmsAau.Application.StudentId.Contracts;

public sealed class StudentIdQrResponse
{
    public string OpaqueToken { get; set; } = string.Empty;
    public string StudentId { get; set; } = string.Empty;
    public string DisplayName { get; set; } = string.Empty;
}

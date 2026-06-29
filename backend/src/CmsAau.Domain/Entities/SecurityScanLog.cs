namespace CmsAau.Domain.Entities;

public class SecurityScanLog
{
    public Guid Id { get; set; }
    public Guid? StudentRecordId { get; set; }
    public Student? Student { get; set; }
    public Guid SecurityOfficerId { get; set; }
    public SecurityOfficer SecurityOfficer { get; set; } = null!;
    public Guid SecurityCheckpointDeviceId { get; set; }
    public SecurityCheckpointDevice SecurityCheckpointDevice { get; set; } = null!;
    public string Outcome { get; set; } = string.Empty;
    public string Source { get; set; } = string.Empty;
    public string FailureReasonCode { get; set; } = string.Empty;
    public DateTime ScannedAtUtc { get; set; } = DateTime.UtcNow;
}

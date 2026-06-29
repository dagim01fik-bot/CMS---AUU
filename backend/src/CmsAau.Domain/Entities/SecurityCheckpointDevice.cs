namespace CmsAau.Domain.Entities;

public class SecurityCheckpointDevice
{
    public Guid Id { get; set; }
    public string DeviceTag { get; set; } = string.Empty;
    public string CheckpointName { get; set; } = string.Empty;
    public string InstallationId { get; set; } = string.Empty;
    public string Description { get; set; } = string.Empty;
    public bool IsActive { get; set; } = true;
    public DateTime? LastSeenAtUtc { get; set; }
    public ICollection<SecurityScanLog> ScanLogs { get; set; } = new List<SecurityScanLog>();
}

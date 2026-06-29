namespace CmsAau.Domain.Entities;

public class SecurityOfficer : User
{
    public string BadgeNumber { get; set; } = string.Empty;
    public ICollection<SecurityScanLog> ScanLogs { get; set; } = new List<SecurityScanLog>();
}

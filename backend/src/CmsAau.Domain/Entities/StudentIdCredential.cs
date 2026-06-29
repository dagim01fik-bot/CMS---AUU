namespace CmsAau.Domain.Entities;

public class StudentIdCredential
{
    public Guid Id { get; set; }
    public Guid StudentRecordId { get; set; }
    public Student Student { get; set; } = null!;
    public string OpaqueTokenHash { get; set; } = string.Empty;
    public DateTime IssuedAtUtc { get; set; } = DateTime.UtcNow;
    public DateTime? RevokedAtUtc { get; set; }
    public bool IsActive { get; set; } = true;
}

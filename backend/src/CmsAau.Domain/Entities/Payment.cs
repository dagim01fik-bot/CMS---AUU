namespace CmsAau.Domain.Entities;

public class Payment
{
    public Guid Id { get; set; }
    public Guid InvoiceId { get; set; }
    public Invoice Invoice { get; set; } = null!;
    public decimal Amount { get; set; }
    public DateTime PaymentDate { get; set; } = DateTime.UtcNow;
    public string PaymentMethod { get; set; } = string.Empty;
    public string TransactionReference { get; set; } = string.Empty;
    public string? ProofOfPaymentUrl { get; set; }
    public string Status { get; set; } = "Pending";
    public string? VerifiedBy { get; set; }
    public DateTime? VerifiedAt { get; set; }
}
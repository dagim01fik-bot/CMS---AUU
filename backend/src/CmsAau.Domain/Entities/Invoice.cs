namespace CmsAau.Domain.Entities;

public class Invoice
{
    public Guid Id { get; set; }
    public string InvoiceNumber { get; set; } = string.Empty;
    public Guid StudentId { get; set; }
    public Student Student { get; set; } = null!;
    public decimal Amount { get; set; }
    public string Description { get; set; } = string.Empty;
    public DateTime DueDate { get; set; }
    public DateTime IssuedDate { get; set; } = DateTime.UtcNow;
    public string Status { get; set; } = "Pending";
    public ICollection<Payment> Payments { get; set; } = new List<Payment>();
}
using System.Security.Claims;
using CmsAau.Application.Common.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace CmsAau.Api.Controllers;

[ApiController]
[Route("api/student-id")]
[Authorize(Roles = "student")]
public sealed class StudentIdController : ControllerBase
{
    private readonly IStudentIdCredentialService _studentIdCredentialService;

    public StudentIdController(IStudentIdCredentialService studentIdCredentialService)
    {
        _studentIdCredentialService = studentIdCredentialService;
    }

    [HttpGet("qr")]
    public async Task<IActionResult> GetQr(CancellationToken cancellationToken)
    {
        var userIdValue = User.FindFirstValue(ClaimTypes.NameIdentifier);
        if (!Guid.TryParse(userIdValue, out var userId))
        {
            return Unauthorized(new { message = "Student identity is invalid." });
        }

        var response = await _studentIdCredentialService.GetOrCreateQrAsync(userId, cancellationToken);
        return Ok(response);
    }
}

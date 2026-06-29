using System.Security.Claims;
using CmsAau.Application.Common.Interfaces;
using CmsAau.Application.Verification.Contracts;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace CmsAau.Api.Controllers;

[ApiController]
[Route("api/verify")]
[Authorize(Roles = "security_officer")]
public sealed class VerificationController : ControllerBase
{
    private readonly IStudentIdVerificationService _studentIdVerificationService;

    public VerificationController(IStudentIdVerificationService studentIdVerificationService)
    {
        _studentIdVerificationService = studentIdVerificationService;
    }

    [HttpPost("student-id")]
    public async Task<IActionResult> VerifyStudentId([FromBody] VerifyStudentIdRequest request, CancellationToken cancellationToken)
    {
        var officerIdValue = User.FindFirstValue(ClaimTypes.NameIdentifier);
        if (!Guid.TryParse(officerIdValue, out var officerId))
        {
            return Unauthorized(new { message = "Officer identity is invalid." });
        }

        try
        {
            var response = await _studentIdVerificationService.VerifyAsync(officerId, request, cancellationToken);
            return Ok(response);
        }
        catch (KeyNotFoundException)
        {
            return NotFound(new { code = VerificationFailureCode.InvalidToken });
        }
        catch (InvalidOperationException ex)
        {
            return BadRequest(new { code = ex.Message });
        }
    }
}

using CmsAau.Application.Auth.Contracts;
using CmsAau.Application.Common.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace CmsAau.Api.Controllers;

[ApiController]
[Route("api/auth")]
public sealed class AuthController : ControllerBase
{
    private readonly IStudentAuthService _studentAuthService;
    private readonly ISecurityOfficerAuthService _securityOfficerAuthService;

    public AuthController(
        IStudentAuthService studentAuthService,
        ISecurityOfficerAuthService securityOfficerAuthService)
    {
        _studentAuthService = studentAuthService;
        _securityOfficerAuthService = securityOfficerAuthService;
    }

    [HttpPost("student/login")]
    public async Task<IActionResult> StudentLogin([FromBody] StudentLoginRequest request, CancellationToken cancellationToken)
    {
        try
        {
            var response = await _studentAuthService.LoginAsync(request, cancellationToken);
            return Ok(response);
        }
        catch (UnauthorizedAccessException ex)
        {
            return Unauthorized(new { message = ex.Message });
        }
        catch (InvalidOperationException ex)
        {
            return BadRequest(new { message = ex.Message });
        }
    }

    [HttpPost("security/login")]
    public async Task<IActionResult> SecurityLogin([FromBody] SecurityOfficerLoginRequest request, CancellationToken cancellationToken)
    {
        try
        {
            var response = await _securityOfficerAuthService.LoginAsync(request, cancellationToken);
            return Ok(new
            {
                response.AccessToken,
                response.Role,
                officer = new
                {
                    id = response.User.Id,
                    fullName = response.User.FullName,
                    badgeNumber = response.User.BadgeNumber,
                },
                checkpoint = response.Checkpoint,
            });
        }
        catch (UnauthorizedAccessException ex)
        {
            return Unauthorized(new { message = ex.Message });
        }
        catch (InvalidOperationException ex)
        {
            return BadRequest(new { message = ex.Message });
        }
    }
}

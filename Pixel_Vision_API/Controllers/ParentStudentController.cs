using System.Net;
using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Pixel_Vision_API.Models;
using Pixel_Vision_API.Models.DTOs.ParentStudntDTOs;
using Pixel_Vision_API.Repository.IRepository;

namespace Pixel_Vision_API.Controllers
{
    [Route("api/parent-student")]
    [ApiController]
    public class ParentStudentController : ControllerBase
    {
        private readonly IParentStudentRepository _parentStudentRepo;
        private readonly IUserRepository _userRepo;
        private readonly IMapper _mapper;
        protected APIResponse _response;
        public ParentStudentController(IMapper _mapper, IParentStudentRepository _parentStudentRepo, IUserRepository _userRepo)
        {
            this._parentStudentRepo = _parentStudentRepo;
            this._userRepo = _userRepo;
            this._mapper = _mapper;
            _response = new();
        }
        [HttpPost("link")]
        [Authorize(Roles = "admin,owner")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status401Unauthorized)]
        [ProducesResponseType(StatusCodes.Status403Forbidden)]
        public async Task<ActionResult<APIResponse>> Link(ParentStudentDto parentStudentDto)
        {
            try
            {
                if (parentStudentDto.ParentId <= 0 || parentStudentDto.StudentId <= 0)
                {
                    _response.StatusCode = HttpStatusCode.BadRequest;
                    _response.IsSuccess = false;
                    _response.ErrorMessages = new List<string>() { "Invalid ID..!" };
                    return NotFound(_response);
                }
                // check validation of Ids
                var parent = await _userRepo.GetAsync(u => u.ID == parentStudentDto.ParentId && u.Role.RoleName == "parent", includeProperties: "Role", tracked: false);
                var student = await _userRepo.GetAsync(u => u.ID == parentStudentDto.StudentId && u.Role.RoleName == "student", includeProperties: "Role");
                if (parent == null)
                {
                    _response.StatusCode = HttpStatusCode.NotFound;
                    _response.IsSuccess = false;
                    _response.ErrorMessages = new List<string>() { "Not a Parent..!" };
                    return NotFound(_response);
                }
                if (student == null)
                {
                    _response.StatusCode = HttpStatusCode.NotFound;
                    _response.IsSuccess = false;
                    _response.ErrorMessages = new List<string>() { "Not a Student..!" };
                    return NotFound(_response);
                }
                ParentStudent parentStudentModel = _mapper.Map<ParentStudent>(parentStudentDto);
                await _parentStudentRepo.CreateAsync(parentStudentModel);
                _response.StatusCode = HttpStatusCode.Created;
                _response.Result = new { message = "Linked Successfully", parentStudentDto };
                return Ok(_response);
            }
            catch (Exception ex)
            {
                _response.StatusCode = HttpStatusCode.InternalServerError;
                _response.IsSuccess = false;
                _response.ErrorMessages = new List<string>() { ex.Message };
            }
            return StatusCode(500, _response);
        }
    }
}

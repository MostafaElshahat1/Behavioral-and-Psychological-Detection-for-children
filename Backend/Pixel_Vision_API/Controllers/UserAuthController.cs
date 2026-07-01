using System.Net;
using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Pixel_Vision_API.Models;
using Pixel_Vision_API.Models.DTOs.RoleDTOs;
using Pixel_Vision_API.Models.DTOs.UserDTOs;
using Pixel_Vision_API.Repository;
using Pixel_Vision_API.Repository.IRepository;

namespace Pixel_Vision_API.Controllers
{
    [Route("api/user")]
    [ApiController]
    public class UserAuthController : ControllerBase
    {
        private readonly IUserRepository _userRepository;
        private readonly IMapper _mapper;
        protected APIResponse _response;
        public UserAuthController(IUserRepository _userRepository, IMapper _mapper)
        {
            this._userRepository = _userRepository;
            this._mapper = _mapper;
            _response = new();
        }


        [HttpPost("register")] // will throw exception if the role Id is greater than the max role_id
        [Authorize(Roles = "admin,owner")]
        [ProducesResponseType(StatusCodes.Status201Created)]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status401Unauthorized)]
        public async Task<ActionResult<APIResponse>> CreateUser([FromBody] UserCreateDto userCreateDto)
        {
            try
            {
                if (userCreateDto == null || userCreateDto.RoleID <= 0)
                {
                    _response.StatusCode = HttpStatusCode.BadRequest;
                    _response.IsSuccess = false;
                    _response.ErrorMessages = new List<string>() { "Non Nullable Entity ..!" };
                    return BadRequest(_response);
                }
                //if (userCreateDto.RoleID == 1 || userCreateDto.RoleID == 3)
                if (userCreateDto.RoleID == 3)
                {
                    _response.StatusCode = HttpStatusCode.Unauthorized;
                    _response.IsSuccess = false;
                    _response.ErrorMessages = new List<string>() { "You can't be assigned to this role..!" };
                    return BadRequest(_response);
                }
                if (!ModelState.IsValid)
                {
                    _response.StatusCode = HttpStatusCode.BadRequest;
                    _response.IsSuccess = false;
                    _response.ErrorMessages = ModelState.Values
                        .SelectMany(v => v.Errors)
                        .Select(e => e.ErrorMessage)
                        .ToList(); 
                    return BadRequest(_response);
                }

                if (await _userRepository.GetAsync(r => r.UserName.ToLower() == userCreateDto.UserName.ToLower()) != null)
                {
                    _response.StatusCode = HttpStatusCode.BadRequest;
                    _response.IsSuccess = false;
                    _response.ErrorMessages = new List<string>() { "UserName is already taken..!" };
                    return BadRequest(_response);
                }

                User userModel = _mapper.Map<User>(userCreateDto);
                await _userRepository.CreateAsync(userModel);
                _response.StatusCode = HttpStatusCode.Created;
                //_response.Result = userModel;
                _response.Result = await _userRepository.GetAsync(u=>u.ID == userModel.ID,includeProperties:"Role");
                return Ok(_response);
                //return CreatedAtRoute("GetUser", new { id = userModel.RoleID }, _response);
            }
            catch (Exception ex)
            {
                _response.StatusCode = HttpStatusCode.InternalServerError;
                _response.IsSuccess = false;
                _response.ErrorMessages = new List<string>() { ex.Message.ToString() };
            }
            return _response;
        }

        [HttpPost("login")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<ActionResult<APIResponse>> Login([FromBody] LoginRequestDto model)
        {
            try
            {
                var loginResponse = await _userRepository.Login(model);
                if (loginResponse.User == null || string.IsNullOrEmpty(loginResponse.Token))
                {
                    _response.StatusCode = HttpStatusCode.BadRequest;
                    _response.IsSuccess = false;
                    _response.ErrorMessages = new List<string>() { "Username or password is incorrect..!" };
                    return BadRequest(_response);
                }
                _response.StatusCode = HttpStatusCode.OK;
                _response.Result = new {
                    Message = "You logged in successfully.",
                    Token = loginResponse.Token,
                    Role = loginResponse.User.Role.RoleName,
                    UserId = loginResponse.User.ID
                };
                return Ok(_response);
            }
            catch (Exception ex)
            {
                _response.StatusCode = HttpStatusCode.InternalServerError;
                _response.IsSuccess = false;
                _response.ErrorMessages = new List<string>() { ex.Message.ToString() };
            }
            return StatusCode(500,_response);

        }


    }
}

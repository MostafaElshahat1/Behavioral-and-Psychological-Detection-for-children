using System.Net;
using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Pixel_Vision_API.Models;
using Pixel_Vision_API.Models.DTOs.RoleDTOs;
using Pixel_Vision_API.Repository.IRepository;

namespace Pixel_Vision_API.Controllers
{
    [Route("api/role")]
    [ApiController]
    [Authorize(Roles = "admin,owner")]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    public class RoleController : ControllerBase
    {
        private readonly IRoleRepository _roleRepository;
        private readonly IMapper _mapper;
        protected APIResponse _response;        
        public RoleController(IRoleRepository roleRepository, IMapper mapper)
        {
            _roleRepository = roleRepository;
            _mapper = mapper;
            _response = new();
        }


        [HttpGet]
        [ProducesResponseType(StatusCodes.Status200OK)]
        public async Task<ActionResult<APIResponse>> GetRoles()
        {
            try
            {
                List<Role> RoleList = await _roleRepository.GetAllAsync();
                _response.StatusCode = HttpStatusCode.OK;
                _response.Result = RoleList;
                return Ok(_response);

            }
            catch (Exception ex)
            {
                _response.StatusCode = HttpStatusCode.InternalServerError;
                _response.IsSuccess = false;
                _response.ErrorMessages = new List<string>() { ex.ToString() };
            }
            return StatusCode(500,_response);
        }

        [HttpGet("{id:int}",Name = "GetRole")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<ActionResult<APIResponse>> GetRole(int id)
        {
            try
            {
                if(id <= 0)
                {
                    _response.StatusCode = HttpStatusCode.BadRequest;
                    _response.IsSuccess = false;
                    _response.ErrorMessages = new List<string>() { "Invalid ID..!"};
                    return BadRequest(_response);
                }
                Role role = await _roleRepository.GetAsync(r=>r.RoleID == id);
                if(role == null)
                {
                    _response.StatusCode = HttpStatusCode.NotFound;
                    _response.IsSuccess = false;
                    _response.ErrorMessages = new List<string>() { "Role doesn't exist..!" };
                    return NotFound(_response);
                }

                _response.StatusCode = HttpStatusCode.OK;
                _response.Result = role;
                return Ok(_response);

            }
            catch (Exception ex)
            {
                _response.StatusCode = HttpStatusCode.InternalServerError;
                _response.IsSuccess = false;
                _response.ErrorMessages = new List<string>() { ex.ToString() };
            }
            return _response;
        }


        [HttpPost]
        [ProducesResponseType(StatusCodes.Status201Created)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<ActionResult<APIResponse>> CreateRole([FromBody] RoleCreateDto roleCreateDto)
        {
            try
            {
                if(roleCreateDto == null)
                {
                    _response.StatusCode = HttpStatusCode.BadRequest;
                    _response.IsSuccess = false;
                    _response.ErrorMessages = new List<string>() { "Invalid Role Data..!" };
                    return BadRequest(_response);
                }
                if (!ModelState.IsValid)
                {
                    _response.StatusCode = HttpStatusCode.BadRequest;
                    _response.IsSuccess = false;
                    _response.ErrorMessages = ModelState.Values
                        .SelectMany(v => v.Errors)
                        .Select(e => e.ErrorMessage)
                        .ToList(); ;
                    return BadRequest(_response);
                }

                if(await _roleRepository.GetAsync(r=>r.RoleName.ToLower() == roleCreateDto.RoleName.ToLower()) != null)
                {
                    _response.StatusCode = HttpStatusCode.BadRequest;
                    _response.IsSuccess = false;
                    _response.ErrorMessages = new List<string>() { "Role is already existing..!" };
                    return BadRequest(_response);
                }

                Role roleModel = _mapper.Map<Role>(roleCreateDto);
                await _roleRepository.CreateAsync(roleModel);
                _response.StatusCode = HttpStatusCode.Created;
                _response.Result = roleModel;
                return CreatedAtRoute("GetRole",new { id = roleModel.RoleID }, _response);
            }
            catch (Exception ex)
            {
                _response.StatusCode = HttpStatusCode.InternalServerError;
                _response.IsSuccess = false;
                _response.ErrorMessages = new List<string>() { ex.Message.ToString() };
            }
            return _response;
        }


        [HttpPut]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<ActionResult<APIResponse>> UpdateRole([FromBody] RoleUpdateDto roleUpdateDto)
        {
            try
            {
                if (roleUpdateDto == null)
                {
                    _response.StatusCode = HttpStatusCode.BadRequest;
                    _response.IsSuccess = false;
                    _response.ErrorMessages = new List<string>() { "Invalid Role Data..!" };
                    return BadRequest(_response);
                }

                if (roleUpdateDto.RoleID <= 0)
                {
                    _response.StatusCode = HttpStatusCode.BadRequest;
                    _response.IsSuccess = false;
                    _response.ErrorMessages = new List<string>() { "Invalid ID..!" };
                    return BadRequest(_response);
                }

                Role role = await _roleRepository.GetAsync(r=>r.RoleID == roleUpdateDto.RoleID, tracked: false);
                if(role == null)
                {
                    _response.StatusCode = HttpStatusCode.NotFound;
                    _response.IsSuccess = false;
                    _response.ErrorMessages = new List<string>() { "Role Not Found..!" };
                    return NotFound(_response);
                }
                Role roleModel = _mapper.Map<Role>(roleUpdateDto); 
                await _roleRepository.UpdateAsync(roleModel);

                _response.StatusCode = HttpStatusCode.OK;
                _response.Result = roleModel;
                return Ok(_response);

            }
            catch(Exception ex)
            {
                _response.StatusCode = HttpStatusCode.InternalServerError;
                _response.IsSuccess = false;
                _response.ErrorMessages = new List<string>() { ex.Message.ToString() };
            }
            return _response;
        }

        [HttpDelete]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status204NoContent)]

        public async Task<ActionResult<APIResponse>> DeleteRole(int id)
        {
            try
            {
                if (id <= 0)
                {
                    _response.StatusCode = HttpStatusCode.BadRequest;
                    _response.IsSuccess = false;
                    _response.ErrorMessages = new List<string>() { "Invalid ID..!" };
                    return BadRequest(_response);
                }

                Role role = await _roleRepository.GetAsync(r => r.RoleID == id);
                if (role == null)
                {
                    _response.StatusCode = HttpStatusCode.NotFound;
                    _response.IsSuccess = false;
                    _response.ErrorMessages = new List<string>() { "Role Not Found..!" };
                    return NotFound(_response);
                }

                await _roleRepository.RemoveAsync(role);
                _response.StatusCode = HttpStatusCode.NoContent;
                return Ok(_response);
            }
            catch(Exception ex)
            {
                _response.StatusCode = HttpStatusCode.InternalServerError;
                _response.IsSuccess = false;
                _response.ErrorMessages = new List<string>() { ex.ToString() };
            }
            return _response;
        }
    }
}

using Azure;
using Microsoft.AspNetCore.Authorization;
using System.Net;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Pixel_Vision_API.Models;
using AutoMapper;
using Pixel_Vision_API.Repository.IRepository;
using Pixel_Vision_API.Models.DTOs.ReportDTOs;
using Pixel_Vision_API.Models.DTOs.UserDTOs;
using Pixel_Vision_API.Repository;
using Pixel_Vision_API.Services;

namespace Pixel_Vision_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]

    public class ReportController : ControllerBase
    {
        private readonly IWeeklyReportRepository _reportRepository;
        private readonly IMapper _mapper;
        protected APIResponse _response;
        public ReportController(IWeeklyReportRepository _reportRepository, IMapper _mapper)
        {
            this._reportRepository = _reportRepository;
            this._mapper = _mapper;
            _response = new();
        }
        [HttpGet]
        [Authorize(Roles = "admin,owner")]
        [ProducesResponseType(StatusCodes.Status401Unauthorized)]
        [ProducesResponseType(StatusCodes.Status403Forbidden)]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<ActionResult<APIResponse>> GetAllReports()
        {
            try
            {
                List<WeeklyReport> reportList = await _reportRepository.GetAllAsync();
                _response.StatusCode = HttpStatusCode.OK;
                //_response.Result = reportList;
                _response.Result = _mapper.Map<List<ReportDto>>(reportList);
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

        [HttpPatch("{id}")]
        [Authorize(Roles = "admin,owner")]

        public async Task<ActionResult<APIResponse>> Patch(int id, ReportPatchDto dto)
        {
            await _reportRepository.PatchReportAsync(id, dto);

            _response.StatusCode = HttpStatusCode.OK;
            _response.Result = "Report updated successfully.";
            return Ok(_response);
        }
        [HttpGet("{student_id}")]
        [Authorize(Roles = "admin,owner,parent")]
        public async Task<ActionResult<APIResponse>> Get(int student_id)
        {
            //var result = await _reportRepository.GetAsync(r=>r.StudentId == student_id);
            var result = await _reportRepository.GetAllAsync(r=>r.StudentId == student_id);
            _response.StatusCode = HttpStatusCode.OK;
            _response.Result = _mapper.Map<List<ReportDto>>(result);
            return Ok(_response);
        }

    }
}

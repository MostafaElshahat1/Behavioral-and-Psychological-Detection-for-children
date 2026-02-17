using System.Net;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Pixel_Vision_API.Models;
using Pixel_Vision_API.Models.DTOs.ImageBehaviorDTOs;
using Pixel_Vision_API.Repository.IRepository;
using Pixel_Vision_API.Services.IServices;

namespace Pixel_Vision_API.Controllers
{
    [Route("api/images")]
    [ApiController]
    [Authorize]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    public class ImageAnalysisController : ControllerBase
    {
        private readonly IMlService _mlService;
        private readonly IImageRepository _imageRepo;
        protected APIResponse _response;

        public ImageAnalysisController(IImageRepository imageRepo, IMlService mlService)
        {
            _imageRepo = imageRepo;
            _mlService = mlService;
            _response = new();
        }

        [HttpPost("analyze")]
        [Authorize]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status401Unauthorized)]
        [ProducesResponseType(StatusCodes.Status403Forbidden)]
        
        public async Task<ActionResult<APIResponse>> Analyze([FromBody] ImageRequestDto imageRequestDto)
        {
            try
            {
                if(imageRequestDto.url == "")
                {
                    _response.StatusCode = HttpStatusCode.BadRequest;
                    _response.IsSuccess = false;
                    _response.ErrorMessages = new List<string>() { "Invalid Image Url..!" };
                    return BadRequest(_response);
                }

                var aiResult = await _mlService.AnalyzeImageAsync(imageRequestDto.url);
                if (aiResult == null || aiResult.Behavior == null || aiResult.Confidence == 0)
                {
                    _response.StatusCode = HttpStatusCode.BadGateway;
                    _response.IsSuccess = false;
                    _response.ErrorMessages = new List<string>() { "AI Response Errror..!" };
                    return StatusCode(502,_response);
                }


                var entity = new ImageBehaviorAnalysis
                {
                    ImageUrl = imageRequestDto.url,
                    Behavior = aiResult.Behavior,
                    Confidence = aiResult.Confidence,
                    Source = "URL"
                };

                await _imageRepo.CreateAsync(entity);
                _response.StatusCode = HttpStatusCode.OK;
                _response.Result = entity;
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

        [HttpGet("analyses")]
        [Authorize(Roles = "admin,owner")]
        [ProducesResponseType(StatusCodes.Status401Unauthorized)]
        [ProducesResponseType(StatusCodes.Status403Forbidden)]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<ActionResult<APIResponse>> GetAllAnalyses()
        {
            try 
            {
                var imageAnalysesList = await _imageRepo.GetAllAsync();
                _response.StatusCode = HttpStatusCode.OK;
                _response.Result = imageAnalysesList;
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

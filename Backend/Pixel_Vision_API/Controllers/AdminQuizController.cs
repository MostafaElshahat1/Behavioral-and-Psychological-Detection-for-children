using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Pixel_Vision_API.Models.DTOs.QuestionDTOs;
using Pixel_Vision_API.Models.DTOs.QuizDTOs;
using Pixel_Vision_API.Models;
using Pixel_Vision_API.Repository.IRepository;
using Azure;
//using Magic_Villa_Villa_API.Models;
using Pixel_Vision_API.Repository;
using System.Net;
using Pixel_Vision_API.Models.DTOs.OptionDTOs;
using Microsoft.AspNetCore.Authorization;

namespace Pixel_Vision_API.Controllers
{
    [ApiController]
    [Route("api/admin/quizzes")]
    [Authorize(Roles = "admin,owner")]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    [ProducesResponseType(StatusCodes.Status500InternalServerError)]
    public class AdminQuizController : ControllerBase
    {
        private readonly IQuizRepository _quizRepo;
        private readonly IQuizAIPredictionRepository _quizAiPredictionRepo;
        private readonly APIResponse _response;

        public AdminQuizController(IQuizAIPredictionRepository _quizAiPredictionRepo, IQuizRepository quizRepo)
        {
            this._quizAiPredictionRepo = _quizAiPredictionRepo;
            _quizRepo = quizRepo;
            _response = new();
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
                var quizPredictionList = await _quizAiPredictionRepo.GetAllAsync();
                _response.StatusCode = HttpStatusCode.OK;
                _response.Result = quizPredictionList;
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


        [HttpGet]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<ActionResult<APIResponse>> GetAllQuizes()
        {
            try
            {
                //List<Quiz> quizList = await _quizRepo.GetAllAsync(includeProperties: "Questions");
                List<Quiz> quizList = await _quizRepo.GetAllQuizesAsync();
                _response.StatusCode = HttpStatusCode.OK;
                var result = quizList.Select(quiz => new QuizResponseDto
                {
                    Id = quiz.Id,
                    Title = quiz.Title,
                    Description = quiz.Description,
                    Questions = quiz.Questions
                         .OrderBy(q => q.Order)
                         .Select(q => new QuestionResponseDto
                         {
                             Id = q.Id,
                             Text = q.Text,
                             Order = q.Order,
                             Options = q.Options.Select(o => new OptionResponseDto
                             {
                                 Id = o.Id,
                                 Text = o.Text,
                                 Value = o.Value
                             }).ToList()
                         }).ToList()
                }).ToList();

                _response.Result = result;
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
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<ActionResult<APIResponse>> CreateQuiz(CreateQuizDto dto)
        {
            try
            {
                var quiz = new Quiz
                {
                    Title = dto.Title,
                    Description = dto.Description
                };

                await _quizRepo.CreateAsync(quiz);
                _response.StatusCode = HttpStatusCode.OK;
                _response.Result = quiz;

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

        [HttpPost("{quizId}/questions")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<ActionResult<APIResponse>> AddQuestion(int quizId, CreateQuestionDto dto)
        {
            try
            {
                var quiz = await _quizRepo.GetByIdAsync(quizId);
                if (quiz is null)
                {
                    _response.StatusCode = HttpStatusCode.NotFound;
                    _response.IsSuccess = false;
                    _response.ErrorMessages = new List<string>() { "quiz not found!" };
                    return NotFound(_response);
                }

                var question = new Question
                {
                    QuizId = quizId,
                    Text = dto.Text,
                    Order = dto.Order,
                    FeatureKey = dto.FeatureKey,
                    Options = dto.Options.Select(o => new Option
                    {
                        Text = o.Text,
                        Value = o.Value
                    }).ToList()
                };

                quiz.Questions.Add(question);
                await _quizRepo.SaveAsync();
                _response.StatusCode = HttpStatusCode.OK;
                _response.Result = "Question was added successfully.";

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
    }

}

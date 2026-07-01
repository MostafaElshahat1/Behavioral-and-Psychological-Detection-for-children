using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Pixel_Vision_API.Models.DTOs.QuizSubmissionDTOs;
using Pixel_Vision_API.Models;
using Pixel_Vision_API.Repository.IRepository;
using Pixel_Vision_API.Services.IServices;
using Azure;
using System.Net;
using Pixel_Vision_API.Models.DTOs.OptionDTOs;
using Pixel_Vision_API.Models.DTOs.QuestionDTOs;
using Pixel_Vision_API.Models.DTOs.QuizDTOs;
using Pixel_Vision_API.Models.DTOs.AnswerDTOs;
using Microsoft.AspNetCore.Authorization;
//using Magic_Villa_Villa_API.Models;

namespace Pixel_Vision_API.Controllers
{
    [ApiController]
    [Route("api/quizzes")]
    [Authorize]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    public class QuizController : ControllerBase
    {
        private readonly IQuizRepository _quizRepo;
        private readonly ISubmissionRepository _submissionRepo;
        private readonly IQuestionRepository _questionRepo;
        private readonly IMlService _mlService;
        private readonly APIResponse _response;

        public QuizController(IQuestionRepository questionRepo,IQuizRepository quizRepo,ISubmissionRepository submissionRepo,IMlService mlService)
        {
            _quizRepo = quizRepo;
            _questionRepo = questionRepo;
            _submissionRepo = submissionRepo;
            _mlService = mlService;
            _response = new();
        }


        [HttpGet("{quizId}")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<ActionResult<APIResponse>> GetQuiz(int quizId)
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
                _response.StatusCode = HttpStatusCode.OK;
                var result = new QuizResponseDto
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
                        })
                        .ToList()
                };

                _response.Result = result;

                return Ok(_response);
            }
            catch (Exception ex)
            {
                _response.StatusCode = HttpStatusCode.InternalServerError;
                _response.IsSuccess = false;
                _response.ErrorMessages = new List<string>() { ex.ToString() };
            }
            return StatusCode(500, _response);
        }

        [HttpPost("{quizId}/submit")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<ActionResult<APIResponse>> SubmitQuiz(int quizId, SubmitQuizDto dto)
        {
            try
            {
                var quiz = await _quizRepo.GetByIdAsync(quizId);
                if (quiz is null)
                {
                    return NotFound(new APIResponse
                    {
                        StatusCode = HttpStatusCode.NotFound,
                        IsSuccess = false,
                        ErrorMessages = new() { "Invalid Quiz Id!" }
                    });
                }

                var quizQuestionIds = quiz.Questions.Select(q => q.Id).ToHashSet();

                if (dto.Answers.Any(a => !quizQuestionIds.Contains(a.QuestionId)))
                {
                    return BadRequest(new APIResponse
                    {
                        IsSuccess = false,
                        ErrorMessages = new() { "Some answers do not belong to this quiz" }
                    });
                }

                if (dto.Answers.GroupBy(a => a.QuestionId).Any(g => g.Count() > 1))
                {
                    return BadRequest(new APIResponse
                    {
                        IsSuccess = false,
                        ErrorMessages = new() { "Duplicate answers detected" }
                    });
                }

                var submission = new QuizSubmission
                {
                    QuizId = quizId,
                    StudentId = dto.StudentId,
                    Answers = dto.Answers.Select(a => new Answer
                    {
                        QuestionId = a.QuestionId,
                        Value = a.Value
                    }).ToList()
                };

                await _submissionRepo.CreateAsync(submission);

                // invoke ML Service
                var QuizAIPrediction = await _mlService.AnalyzeQuizAsync(submission.Id);


                var questionFeatureMap = quiz.Questions
                    .ToDictionary(q => q.Id, q => q.FeatureKey);

                var resultDto = new
                {
                    QuizAIPrediction,
                    SubmissionId = submission.Id,
                    QuizId = quizId,
                    StudentId = submission.StudentId,
                    AnswersCount = submission.Answers.Count,
                    Answers = dto.Answers.Select(a => new
                    {
                        QuestionId = a.QuestionId,
                        Value = a.Value,
                        FeatureKey = questionFeatureMap[a.QuestionId]
                    }).ToList()
                };



                return Ok(new APIResponse
                {
                    StatusCode = HttpStatusCode.OK,
                    Result = resultDto
                });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new APIResponse
                {
                    StatusCode = HttpStatusCode.InternalServerError,
                    IsSuccess = false,
                    ErrorMessages = new() { ex.Message }
                });
            }
        }


    }
}

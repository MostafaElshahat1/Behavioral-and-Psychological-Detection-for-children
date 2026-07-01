using System;
using System.Globalization;
using System.Net;
using System.Text.Json;
using Humanizer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Pixel_Vision_API.Data;
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
        private readonly IStudentAnalysisRepository _studentAnalysisRepo;
        private readonly IRiskCalculatorService _riskCalculator;
        private readonly IWeeklyReportRepository _weeklyReportRepo;
        private readonly ApplicationDbContext _context;
        protected APIResponse _response;

        //private readonly AppDbContext _context;

        public ImageAnalysisController(ApplicationDbContext context, IWeeklyReportRepository weeklyReportRepo, IStudentAnalysisRepository studentAnalysisRepo, IImageRepository imageRepo, IMlService mlService, IRiskCalculatorService riskCalculator)
        {
            _studentAnalysisRepo = studentAnalysisRepo;
            _weeklyReportRepo = weeklyReportRepo;
            _imageRepo = imageRepo;
            _mlService = mlService;
            _riskCalculator = riskCalculator;
            _context = context;
            _response = new();
        }

        [HttpPost("analyze-class")]
        [Authorize(Roles = "admin,owner")]
        public async Task<IActionResult> AnalyzeClass(IFormFile image)
        {
            if (image == null || image.Length == 0)
                return BadRequest("Image is required.");

            var recognition = await _mlService.RecognizeAsync(image);

            var analyses = new List<StudentAnalysis>();

            foreach (var student in recognition.Students)
            {
                // Run ML requests in parallel
                var emotionTask = _mlService.PredictEmotionAsync(student.CropPath);
                var behaviorTask = _mlService.PredictBehaviorAsync(student.CropPath);

                await Task.WhenAll(emotionTask, behaviorTask);

                var emotion = await emotionTask;
                var behavior = await behaviorTask;

                var emotionResult = emotion?.Results?.FirstOrDefault();

                var currentWeek = ISOWeek.GetWeekOfYear(DateTime.UtcNow);

                var report = await _weeklyReportRepo.GetAsync(
                    r => r.StudentId == student.Id &&
                         r.WeekNumber == currentWeek);

                if (report == null)
                {
                    report = new WeeklyReport
                    {
                        StudentId = student.Id,
                        WeekNumber = currentWeek
                    };

                    await _weeklyReportRepo.CreateAsync(report);
                }

                report.TotalImages++;

                // Emotion Counts
                switch (emotionResult?.Emotion)
                {
                    case "Happy":
                        report.HappyCount++;
                        break;

                    case "Sad":
                        report.SadCount++;
                        break;

                    case "Angry":
                        report.AngryCount++;
                        break;

                    case "Neutral":
                        report.NeutralCount++;
                        break;

                    case "Surprise":
                        report.SurpriseCount++;
                        break;
                }

                // Behavior Counts
                switch (behavior?.Behavior)
                {
                    case "Sleeping":
                        report.SleepingCount++;
                        break;

                    case "Turning_Around":
                        report.LookingBackCount++;
                        break;

                    case "Raising_Hand":
                        report.HandRaisedCount++;
                        break;

                    case "Writting":
                        report.WrittingCount++;
                        break;

                    case "Reading":
                        report.ReadingCount++;
                        break;

                    case "Standing":
                        report.StandingCount++;
                        break;

                    case "Looking_Forward":
                        report.LookingForwardCount++;
                        break;
                }

                await _weeklyReportRepo.SaveAsync();

                analyses.Add(new StudentAnalysis
                {
                    StudentId = student.Id,
                    ImageUrl = student.CropPath,

                    Emotion = emotionResult?.Emotion ?? "Unknown",
                    EmotionConfidence = emotionResult?.Confidence ?? 0,

                    Behavior = behavior?.Behavior ?? "Unknown",
                    BehaviorConfidence = behavior?.Confidence ?? 0,

                    CreatedAt = DateTime.UtcNow
                });
            }

            _context.StudentAnalyses.AddRange(analyses);

            await _context.SaveChangesAsync();

            return Ok(analyses);
        }
        //public async Task<IActionResult> AnalyzeClass(IFormFile image)
        //{
        //    if (image == null || image.Length == 0)
        //        return BadRequest("Image is required.");

        //    var recognition =
        //        await _mlService.RecognizeAsync(image);

        //    var tasks = recognition.Students.Select(async student =>
        //    {
        //        var emotion = await _mlService.PredictEmotionAsync(student.CropPath);
        //        //switch (emotion.Results.fi)
        //        //{
        //        //    case "neutral":
        //        //        break;
        //        //}


        //        var behavior = await _mlService.PredictBehaviorAsync(student.CropPath);

        //        var emotionResult = emotion?.Results?.FirstOrDefault();

        //        var report = await _weeklyReportRepo.GetAsync(r => r.StudentId == student.Id);

        //        if (report == null)
        //        {
        //            report = new WeeklyReport
        //            {
        //                StudentId = student.Id
        //            };
        //            await _weeklyReportRepo.CreateAsync(report);
        //        }

        //        switch (emotionResult?.Emotion?.ToLower())
        //        {
        //            case "Happy":
        //                report.HappyCount++;
        //                break;

        //            case "Sad":
        //                report.SadCount++;
        //                break;

        //            case "Angry":
        //                report.AngryCount++;
        //                break;

        //            case "Neutral":
        //                report.NeutralCount++;
        //                break;

        //            case "Surprise":
        //                report.SurpriseCount++;
        //                break;

        //            default:
        //                // Unknown emotion
        //                break;
        //        }


        //        switch (behavior?.Behavior?.ToLower())
        //        {
        //            case "Sleeping":
        //                report.SleepingCount++;
        //                break;

        //            case "Turning_Around":
        //                report.LookingBackCount++;
        //                break;

        //            case "Raising_Hand":
        //                report.HandRaisedCount++;
        //                break;

        //            case "Writting":
        //                report.WrittingCount++;
        //                break;

        //            case "Reading":
        //                report.ReadingCount++;
        //                break;

        //            case "Standing":
        //                report.StandingCount++;
        //                break;

        //            case "Looking_Forward":
        //                report.LookingForwardCount++;
        //                break;

        //            default:
        //                break;
        //        }
        //        await _weeklyReportRepo.SaveAsync();


        //        return new StudentAnalysis
        //        {
        //            StudentId = student.Id,
        //            ImageUrl = student.CropPath,

        //            Emotion = emotionResult?.Emotion ?? "Unknown",
        //            EmotionConfidence = emotionResult?.Confidence ?? 0,

        //            Behavior = behavior?.Behavior ?? "Unknown",
        //            BehaviorConfidence = behavior?.Confidence ?? 0,

        //            CreatedAt = DateTime.UtcNow
        //        };
        //    });


        //    var analyses = await Task.WhenAll(tasks);

        //    _context.StudentAnalyses.AddRange(analyses);

        //    await _context.SaveChangesAsync();

        //    return Ok(analyses);
        //}

        [HttpPost("analyze-video")]
        [Authorize]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status401Unauthorized)]
        [ProducesResponseType(StatusCodes.Status403Forbidden)]
        public async Task<IActionResult> AnalyzeVideo(IFormFile file)
        {
            if (file == null || file.Length == 0)
                return BadRequest("No video uploaded");

            var client = new HttpClient();

            using var form = new MultipartFormDataContent();

            using var stream = file.OpenReadStream();

            form.Add(new StreamContent(stream), "file", file.FileName);

            var response = await client.PostAsync("https://ahmed-nn-violence-detection-model.hf.space/predict", form);

            if (!response.IsSuccessStatusCode)
                return StatusCode((int)response.StatusCode);

            var json = await response.Content.ReadAsStringAsync();

            var result = JsonSerializer.Deserialize<VideoPredictionResponse>(json,
                new JsonSerializerOptions { PropertyNameCaseInsensitive = true });

            foreach (var p in result.Prediction)
            {
                var detection = new VideoDetection
                {
                    Source = result.Source,
                    FileName = result.Filename,
                    ViolancePercentage = p[0],
                    NonViolancePercentage = p[1]
                };

                _context.VideoDetections.Add(detection);
            }

            await _context.SaveChangesAsync();

            return Ok(result);
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
                var studentAnalysisList = await _studentAnalysisRepo.GetAllAsync();
                _response.StatusCode = HttpStatusCode.OK;
                _response.Result = studentAnalysisList;
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

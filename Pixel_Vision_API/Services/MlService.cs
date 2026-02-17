using Pixel_Vision_API.Models.DTOs.ImageBehaviorDTOs;
using System.Net.Http;
using Pixel_Vision_API.Repository.IRepository;
using Pixel_Vision_API.Services.IServices;
using Pixel_Vision_API.Models.DTOs.QuizDTOs;
using Pixel_Vision_API.Models;

namespace Pixel_Vision_API.Services
{
    public class MlService : IMlService
    {
        private readonly ISubmissionRepository _repo;
        private readonly IQuizAIPredictionRepository _quizAIPredictionRepository;
        private readonly HttpClient _quizClient;
        private readonly HttpClient _imageClient;

        public MlService(ISubmissionRepository repo, IHttpClientFactory factory)
        {
            _repo = repo;
            _quizClient = factory.CreateClient("QuizAiService");
            _imageClient = factory.CreateClient("ImageAiService");
        }

        public async Task<PredictionResponseDto> AnalyzeQuizAsync(int submissionId)
        {
            var submission = await _repo.GetWithAnswersAsync(submissionId);
            if (submission is null) throw new Exception("Submission not found");

            var payload = submission.Answers
                .ToDictionary(
                    a => a.Question.FeatureKey,
                    a => a.Value
                );

            //var payload = new PredictionDto
            //{
                
            //};

            var response = await _quizClient.PostAsJsonAsync("", payload);

            if (!response.IsSuccessStatusCode)
                throw new Exception("AI Service failed");

            var result = await response.Content.ReadFromJsonAsync<PredictionResponseDto>();
            if (result == null)
                return null!;

            var analysis = new QuizAIPrediction
            {
                Status = result.Status,
                RiskId = result.Prediction.RiskId,
                RiskLabel = result.Prediction.RiskLabel,
                ProbabilityScore = double.Parse(
                result.Prediction.ProbabilityScore.Replace("%", "")
           ),
                InterventionNeeded = result.Prediction.InterventionNeeded,
                Recommendation = result.Recommendation
            };

            await _quizAIPredictionRepository.CreateAsync(analysis);

            return result! ;
        }




        public async Task<ImageResponseDto> AnalyzeImageAsync(string imageUrl)
        {
            var payload = new ImageRequestDto
            {
                url = imageUrl
            };

            var response = await _imageClient.PostAsJsonAsync("", payload);

            if (!response.IsSuccessStatusCode)
                throw new Exception("AI Service failed");

            var result = await response.Content.ReadFromJsonAsync<ImageResponseDto>();

            return result!;
        }
    }

}

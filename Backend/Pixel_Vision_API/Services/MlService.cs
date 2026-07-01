using Pixel_Vision_API.Models.DTOs.ImageBehaviorDTOs;
using System.Net.Http;
using Pixel_Vision_API.Repository.IRepository;
using Pixel_Vision_API.Services.IServices;
using Pixel_Vision_API.Models.DTOs.QuizDTOs;
using Pixel_Vision_API.Models;
using System.Net.Http.Headers;


namespace Pixel_Vision_API.Services
{
    public class MlService : IMlService
    {
        private readonly ISubmissionRepository _repo;
        private readonly IQuizAIPredictionRepository _quizAIPredictionRepository;
        private readonly HttpClient _quizClient;
        private readonly HttpClient _imageClient;
        private readonly HttpClient _emotionClient;
        private readonly HttpClient _behaviorClient;
        private readonly HttpClient _recognitionClient;

        public MlService(IQuizAIPredictionRepository quizAIPredictionRepository, ISubmissionRepository repo, IHttpClientFactory factory)
        {
            _repo = repo;
            _emotionClient = factory.CreateClient("emotion");
            _behaviorClient = factory.CreateClient("behavior");
            _recognitionClient = factory.CreateClient("recognition");
            _quizAIPredictionRepository = quizAIPredictionRepository;
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
                StudentId = submission.StudentId,
                risk_level = result.risk_level,
                risk_score = result.risk_score
                //Status = result.Status,
                //RiskId = result.Prediction.RiskId,
                //RiskLabel = result.Prediction.RiskLabel,
                //ProbabilityScore = double.Parse(
                //result.Prediction.ProbabilityScore.Replace("%", "")
                //),
                //InterventionNeeded = result.Prediction.InterventionNeeded,
                //Recommendation = result.Recommendation
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



    public async Task<RecognitionResponse> RecognizeAsync(IFormFile image)
    {
        using var content = new MultipartFormDataContent();

        await using var stream = image.OpenReadStream();

        var fileContent = new StreamContent(stream);

        fileContent.Headers.ContentType =
            new MediaTypeHeaderValue(image.ContentType);

        content.Add(
            fileContent,
            "file",
            image.FileName);

        var response = await _recognitionClient.PostAsync(
            "https://ahmed-nn-face-recognition-api.hf.space/analyze",
            content);

        if (!response.IsSuccessStatusCode)
        {
            var error = await response.Content.ReadAsStringAsync();
            throw new Exception(error);
        }

        return await response.Content.ReadFromJsonAsync<RecognitionResponse>()
               ?? throw new Exception("Recognition failed");
    }


    public async Task<EmotionResponse> PredictEmotionAsync(string imageUrl)
        {
            var response =
                await _emotionClient.PostAsJsonAsync(
                    "https://mostafaelshahat1-emotion-detection-yolo.hf.space/analyze",
                    new { url = imageUrl });

            response.EnsureSuccessStatusCode();

            return await response.Content
                .ReadFromJsonAsync<EmotionResponse>()
                ?? throw new Exception();
        }

        public async Task<BehaviorResponse> PredictBehaviorAsync(string imageUrl)
        {
            var response =
                await _behaviorClient.PostAsJsonAsync(
                    "https://mostafaelshahat1-behaviormodel.hf.space/predict",
                    new { url = imageUrl });

            response.EnsureSuccessStatusCode();

            return await response.Content
                .ReadFromJsonAsync<BehaviorResponse>()
                ?? throw new Exception();
        }
    }

}

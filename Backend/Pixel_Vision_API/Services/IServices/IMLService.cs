using Pixel_Vision_API.Models;
using Pixel_Vision_API.Models.DTOs.ImageBehaviorDTOs;
using Pixel_Vision_API.Models.DTOs.QuizDTOs;

namespace Pixel_Vision_API.Services.IServices
{
    public interface IMlService
    {
        Task<PredictionResponseDto> AnalyzeQuizAsync(int submissionId);
        Task<ImageResponseDto> AnalyzeImageAsync(string imageUrl);
        Task<RecognitionResponse> RecognizeAsync(IFormFile image);
        Task<BehaviorResponse> PredictBehaviorAsync(string imageUrl);
        Task<EmotionResponse> PredictEmotionAsync(string imageUrl);
    }

}

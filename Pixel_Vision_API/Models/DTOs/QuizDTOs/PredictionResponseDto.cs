using System.Text.Json.Serialization;

namespace Pixel_Vision_API.Models.DTOs.QuizDTOs
{
    public class PredictionResponseDto
    {
        [JsonPropertyName("status")]
        public string Status { get; set; } = string.Empty;

        [JsonPropertyName("prediction")]
        public PredictionDto Prediction { get; set; } = new();

        [JsonPropertyName("recommendation")]
        public string Recommendation { get; set; } = string.Empty;
    }

}

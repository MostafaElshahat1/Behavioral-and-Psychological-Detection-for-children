namespace Pixel_Vision_API.Models.DTOs.QuizDTOs
{
    using System.Text.Json.Serialization;

    public class PredictionDto
    {
        [JsonPropertyName("risk_id")]
        public int RiskId { get; set; }

        [JsonPropertyName("risk_label")]
        public string RiskLabel { get; set; } = string.Empty;

        [JsonPropertyName("probability_score")]
        public string ProbabilityScore { get; set; } = string.Empty;

        [JsonPropertyName("intervention_needed")]
        public bool InterventionNeeded { get; set; }
    }

}

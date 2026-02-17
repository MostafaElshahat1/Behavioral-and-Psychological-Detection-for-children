namespace Pixel_Vision_API.Models
{
    public class QuizAIPrediction
    {
        public int Id { get; set; }

        public string Status { get; set; } = string.Empty;

        public int RiskId { get; set; }
        public string RiskLabel { get; set; } = string.Empty;

        public double ProbabilityScore { get; set; }

        public bool InterventionNeeded { get; set; }

        public string Recommendation { get; set; } = string.Empty;

        public DateTime CreatedAt { get; set; } = DateTime.Now;
    }
}

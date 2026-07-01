using System.ComponentModel.DataAnnotations;

namespace Pixel_Vision_API.Models
{
    public class StudentAnalysis
    {
        [Key]
        public int AnalysisId { get; set; }
        public int StudentId { get; set; }

        public string ImageUrl { get; set; } = string.Empty;

        public string Emotion { get; set; } = string.Empty;

        public double EmotionConfidence { get; set; }

        public string Behavior { get; set; } = string.Empty;

        public double BehaviorConfidence { get; set; }

        public DateTime CreatedAt { get; set; } 
    }
}

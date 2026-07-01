using System.Text.Json.Serialization;

namespace Pixel_Vision_API.Models
{
    public class EmotionResponse
    {
        [JsonPropertyName("media_type")]
        public string MediaType { get; set; } = string.Empty;

        [JsonPropertyName("student_count")]
        public int StudentCount { get; set; }

        [JsonPropertyName("results")]
        public List<EmotionResult> Results { get; set; } = [];
    }

    public class EmotionResult
    {
        [JsonPropertyName("emotion")]
        public string Emotion { get; set; } = string.Empty;

        [JsonPropertyName("confidence")]
        public double Confidence { get; set; }

        [JsonPropertyName("bbox")]
        public EmotionBBox BBox { get; set; } = new();
    }

    public class EmotionBBox
    {
        [JsonPropertyName("x")]
        public int X { get; set; }

        [JsonPropertyName("y")]
        public int Y { get; set; }

        [JsonPropertyName("w")]
        public int W { get; set; }

        [JsonPropertyName("h")]
        public int H { get; set; }
    }
}

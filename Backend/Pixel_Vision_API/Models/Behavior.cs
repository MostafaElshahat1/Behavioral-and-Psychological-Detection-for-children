using System.Text.Json.Serialization;

namespace Pixel_Vision_API.Models
{
    public class BehaviorResponse
    {
        [JsonPropertyName("type")]
        public string Type { get; set; } = string.Empty;

        [JsonPropertyName("behavior")]
        public string Behavior { get; set; } = string.Empty;

        [JsonPropertyName("confidence")]
        public double Confidence { get; set; }
    }
}

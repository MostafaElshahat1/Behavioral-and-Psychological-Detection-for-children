using System.Text.Json.Serialization;

namespace Pixel_Vision_API.Models
{
    public class RecognitionResponse
    {
        [JsonPropertyName("total_people")]
        public int TotalPeople { get; set; }

        [JsonPropertyName("known_count")]
        public int KnownCount { get; set; }

        [JsonPropertyName("unknown_count")]
        public int UnknownCount { get; set; }

        [JsonPropertyName("students")]
        public List<RecognizedStudent> Students { get; set; } = [];
    }

    public class RecognizedStudent
    {
        [JsonPropertyName("id")]
        public int Id { get; set; }

        [JsonPropertyName("crop_path")]
        public string CropPath { get; set; } = string.Empty;

        [JsonPropertyName("bbox")]
        public List<int> BBox { get; set; } = [];
    }
}

namespace Pixel_Vision_API.Models
{
    public class VideoPredictionResponse
    {
        public string Status { get; set; }

        public string Source { get; set; }

        public string Filename { get; set; }

        public List<List<double>> Prediction { get; set; }
    }
}

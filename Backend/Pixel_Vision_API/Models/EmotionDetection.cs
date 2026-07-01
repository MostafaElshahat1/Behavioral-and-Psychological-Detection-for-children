namespace Pixel_Vision_API.Models
{
    public class EmotionDetection
    {
        public int Id { get; set; }

        public string Emotion { get; set; }

        public double Confidence { get; set; }

        public int X { get; set; }
        public int Y { get; set; }
        public int W { get; set; }
        public int H { get; set; }

        public DateTime CreatedAt { get; set; } = DateTime.Now;
    }
}

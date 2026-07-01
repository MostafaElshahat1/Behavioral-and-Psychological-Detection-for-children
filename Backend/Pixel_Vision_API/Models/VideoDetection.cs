namespace Pixel_Vision_API.Models
{
    public class VideoDetection
    {
        public int Id { get; set; }

        public string Source { get; set; }

        public string FileName { get; set; }

        public double ViolancePercentage { get; set; }

        public double NonViolancePercentage { get; set; }

        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    }
}

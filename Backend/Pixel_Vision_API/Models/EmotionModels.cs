namespace Pixel_Vision_API.Models
{
    public class AnalyzeResponse
    {
        public int Student_Count { get; set; }
        public List<DetectionResult> Results { get; set; }
    }

    public class DetectionResult
    {
        public string Emotion { get; set; }
        public double Confidence { get; set; }
        public BBox Bbox { get; set; }
    }

    public class BBox
    {
        public int X { get; set; }
        public int Y { get; set; }
        public int W { get; set; }
        public int H { get; set; }
    }
}

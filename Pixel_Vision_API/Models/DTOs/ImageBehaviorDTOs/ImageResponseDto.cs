namespace Pixel_Vision_API.Models.DTOs.ImageBehaviorDTOs
{
    public class ImageResponseDto
    {
        public int StudentId { get; set; } = 6; // Osama (student)
        public string Behavior { get; set; } = null!;
        public double Confidence { get; set; } 
        public string Source { get; set; } = null!;
    }
}

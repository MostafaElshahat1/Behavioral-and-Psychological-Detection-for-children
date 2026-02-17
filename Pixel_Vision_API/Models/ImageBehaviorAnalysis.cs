using System.ComponentModel.DataAnnotations;

namespace Pixel_Vision_API.Models
{
    public class ImageBehaviorAnalysis
    {
        //[Key]
        public int Id { get; set; }
        //public int StudentId { get; set; } = 0;
        public string ImageUrl { get; set; } = null!;
        public string Behavior { get; set; } = null!;
        public double Confidence { get; set; }
        public string Source { get; set; } = null!;
        //public User? Student { get; set; }
        public DateTime CreatedAt { get; set; } = DateTime.Now;
    }

}

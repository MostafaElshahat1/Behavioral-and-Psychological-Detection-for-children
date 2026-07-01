using System.ComponentModel.DataAnnotations;

namespace Pixel_Vision_API.Models.DTOs.QuizDTOs
{
    public class CreateQuizDto
    {
        [Required]
        [StringLength(150, MinimumLength = 3)]
        public string Title { get; set; } = null!;

        [Required]
        [StringLength(500)]
        public string Description { get; set; } = null!;
    }

}

using System.ComponentModel.DataAnnotations;
using Pixel_Vision_API.Models.DTOs.OptionDTOs;

namespace Pixel_Vision_API.Models.DTOs.QuestionDTOs
{
    public class CreateQuestionDto
    {
        [Required]
        [StringLength(500)]
        public string Text { get; set; } = null!;

        [Range(1, 100)]
        public int Order { get; set; }

        [Required]
        //[RegularExpression(@"^[A-Z0-9_]+$",
        //    ErrorMessage = "FeatureKey must be uppercase (e.g. PHQ_1)")]
        public string FeatureKey { get; set; } = null!;

        [MinLength(2)]
        public List<CreateOptionDto> Options { get; set; } = new();
    }

}

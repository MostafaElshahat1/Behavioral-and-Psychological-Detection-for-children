using System.ComponentModel.DataAnnotations;

namespace Pixel_Vision_API.Models.DTOs.OptionDTOs
{
    public class CreateOptionDto
    {
        [Required]
        [StringLength(200)]
        public string Text { get; set; } = null!;

        //[Range(0, 10)]
        public int Value { get; set; }
    }

}

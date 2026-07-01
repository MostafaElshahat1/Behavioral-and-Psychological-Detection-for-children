using Pixel_Vision_API.Models.DTOs.OptionDTOs;

namespace Pixel_Vision_API.Models.DTOs.QuestionDTOs
{
    public class QuestionResponseDto
    {
        public int Id { get; set; }
        public string Text { get; set; } = null!;
        public int Order { get; set; }

        public List<OptionResponseDto> Options { get; set; } = new();
    }

}

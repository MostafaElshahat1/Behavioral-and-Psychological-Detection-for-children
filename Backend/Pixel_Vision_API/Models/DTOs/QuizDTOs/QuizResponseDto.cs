using Pixel_Vision_API.Models.DTOs.QuestionDTOs;

namespace Pixel_Vision_API.Models.DTOs.QuizDTOs
{
    public class QuizResponseDto
    {
        public int Id { get; set; }
        public string Title { get; set; } = null!;
        public string Description { get; set; } = null!;
        public List<QuestionResponseDto> Questions { get; set; } = new();
    }

}

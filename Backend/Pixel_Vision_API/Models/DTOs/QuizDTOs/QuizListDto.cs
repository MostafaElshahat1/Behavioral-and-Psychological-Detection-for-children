namespace Pixel_Vision_API.Models.DTOs.QuizDTOs
{
    public class QuizListDto
    {
        public int Id { get; set; }
        public string Title { get; set; } = null!;
        public string Description { get; set; } = null!;
        public int QuestionsCount { get; set; }
    }

}

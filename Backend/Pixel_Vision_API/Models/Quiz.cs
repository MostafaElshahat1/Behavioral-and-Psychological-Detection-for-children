namespace Pixel_Vision_API.Models
{
    public class Quiz
    {
        public int Id { get; set; }
        public string Title { get; set; } = null!;
        public string Description { get; set; } = null!;
        public bool IsActive { get; set; } = true;

        public ICollection<Question> Questions { get; set; } = new List<Question>();
    }

}

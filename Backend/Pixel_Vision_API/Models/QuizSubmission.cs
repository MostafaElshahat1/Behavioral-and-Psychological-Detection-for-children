namespace Pixel_Vision_API.Models
{
    public class QuizSubmission
    {
        public int Id { get; set; }
        public int QuizId { get; set; }

        public int StudentId { get; set; } = 0;
        public DateTime SubmittedAt { get; set; } = DateTime.UtcNow;

        public Quiz Quiz { get; set; } = null!;
        public ICollection<Answer> Answers { get; set; } = new List<Answer>();
    }

}

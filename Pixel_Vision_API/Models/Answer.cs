namespace Pixel_Vision_API.Models
{
    public class Answer
    {
        public int Id { get; set; }
        public int QuizSubmissionId { get; set; }
        public int QuestionId { get; set; }

        public string Value { get; set; }

        public QuizSubmission QuizSubmission { get; set; } = null!;
        public Question Question { get; set; } = null!;
    }

}

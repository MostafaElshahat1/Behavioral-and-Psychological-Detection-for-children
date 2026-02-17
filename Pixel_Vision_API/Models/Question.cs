namespace Pixel_Vision_API.Models
{
    public class Question
    {
        public int Id { get; set; }
        public int QuizId { get; set; }

        public string Text { get; set; } = null!;
        public int Order { get; set; }
        public string FeatureKey { get; set; } = null!; // PHQ_1, PHQ_2 ...

        public Quiz Quiz { get; set; } = null!;
        public ICollection<Option> Options { get; set; } = new List<Option>();
    }

}

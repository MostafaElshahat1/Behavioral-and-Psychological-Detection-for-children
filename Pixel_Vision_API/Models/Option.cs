namespace Pixel_Vision_API.Models
{
    public class Option
    {
        public int Id { get; set; }
        public int QuestionId { get; set; }

        public string Text { get; set; } = null!;
        public string Value { get; set; }

        public Question Question { get; set; } = null!;
    }

}

namespace Pixel_Vision_API.Models
{
    public class ParentStudent
    {
        public int ParentId { get; set; }
        public User? Parent { get; set; }

        public int StudentId { get; set; }
        public User? Student { get; set; }
    }

}

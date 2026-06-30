using System.ComponentModel.DataAnnotations;

namespace Pixel_Vision_API.Models.DTOs.AnswerDTOs
{
    public class SubmitAnswerDto
    {
        [Required]
        public int QuestionId { get; set; }

        //[Range(0, 3)]
        public int Value { get; set; }
    }

}

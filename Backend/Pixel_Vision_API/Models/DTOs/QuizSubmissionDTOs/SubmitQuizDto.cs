using System.ComponentModel.DataAnnotations;
using Pixel_Vision_API.Models.DTOs.AnswerDTOs;

namespace Pixel_Vision_API.Models.DTOs.QuizSubmissionDTOs
{
    public class SubmitQuizDto
    {
        [Required]
        //public int StudentId { get; set; } = 0;
        public int StudentId { get; set; }

        [MinLength(1)]
        public List<SubmitAnswerDto> Answers { get; set; } = new();
    }
    
}


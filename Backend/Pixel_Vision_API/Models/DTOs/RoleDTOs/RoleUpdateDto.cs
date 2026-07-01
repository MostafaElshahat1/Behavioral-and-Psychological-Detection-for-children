using System.ComponentModel.DataAnnotations;

namespace Pixel_Vision_API.Models.DTOs.RoleDTOs
{
    public class RoleUpdateDto
    {
        public int RoleID { get; set; }
        [Required]
        [MinLength(5)]
        public string RoleName { get; set; }
    }
}

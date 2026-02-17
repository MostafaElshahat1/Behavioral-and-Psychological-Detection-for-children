using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
//using Pixel_Vision_API.Models;
namespace Pixel_Vision_API.Models.DTOs.UserDTOs
{
    public class UserDto
    {
        public int ID { get; set; }
        [Required, MinLength(3)]
        public string UserName { get; set; }
        [Required]
        [RegularExpression("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$")]
        public string Email { get; set; }
        //[RegularExpression("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?#&])[A-Za-z\\d@$!%*?&#]{8,}$")]
        //public string Password { get; set; }
        [Required]
        [RegularExpression("^(\\+201|01|00201)[0-2,5]{1}[0-9]{8}")]
        public string PhoneNumber { get; set; }
        [ForeignKey("Role")]
        public int RoleID { get; set; }
        public DateTime CreatedDate { get; set; } = DateTime.Now;
        public DateTime UpdatedDate { get; set; }
    }
}



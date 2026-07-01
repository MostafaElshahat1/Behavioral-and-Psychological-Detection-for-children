namespace Pixel_Vision_API.Models.DTOs.UserDTOs
{
    public class LoginResponseDto
    {
        public User User { get; set; }
        public string Token { get; set; }
    }
}

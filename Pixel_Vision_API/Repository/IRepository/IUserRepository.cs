using Pixel_Vision_API.Models;
using Pixel_Vision_API.Models.DTOs.UserDTOs;

namespace Pixel_Vision_API.Repository.IRepository
{
    public interface IUserRepository:IBaseRepository<User>
    {
        Task<User> UpdateAsync(User entity);
        Task<IEnumerable<User>> GetByRoleAsync(string role);
        Task<LoginResponseDto> Login(LoginRequestDto loginRequestDto);
    }
}

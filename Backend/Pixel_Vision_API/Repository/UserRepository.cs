using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using Pixel_Vision_API.Data;
using Pixel_Vision_API.Models;
using Pixel_Vision_API.Models.DTOs.UserDTOs;
using Pixel_Vision_API.Repository.IRepository;

namespace Pixel_Vision_API.Repository
{
    public class UserRepository : BaseRepository<User>, IUserRepository
    {
        private readonly ApplicationDbContext _context;
        private string _secretkety;
        public UserRepository(ApplicationDbContext context, IConfiguration configuration)
            : base(context)
        {
            _context = context;
            _secretkety = configuration.GetValue<string>("ApiSettings:Secret")!;
        }

        public async Task<User> UpdateAsync(User entity)
        {
            entity.UpdatedDate = DateTime.Now;
            _context.Users.Update(entity);
            await _context.SaveChangesAsync();
            return entity;
        }

        public async Task<IEnumerable<User>> GetByRoleAsync(string role)
        {

            List<User> userList = await GetAllAsync(u => u.Role.RoleName == role, includeProperties: "Role");
            return userList;
        }

        public async Task<LoginResponseDto> Login(LoginRequestDto loginRequestDto)
        {
            var user = await _context.Users.Include(u=>u.Role).FirstOrDefaultAsync(
                u => u.UserName.ToLower() == loginRequestDto.UserName.ToLower()
                && u.Password == loginRequestDto.Password);

            if (user == null)
            {
                return new LoginResponseDto()
                {
                    Token = "",
                    User = null
                };

            }

            // if ok => Generate token
            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.ASCII.GetBytes(_secretkety);

            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new Claim[]
                {
                    new Claim(ClaimTypes.Name, user.ID.ToString()),
                    new Claim(ClaimTypes.Role, user.Role.RoleName)// flag 
                }),
                Expires = DateTime.Now.AddDays(7),
                SigningCredentials = new(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
            };

            var token = tokenHandler.CreateToken(tokenDescriptor);
            LoginResponseDto loginRresponseDto = new LoginResponseDto()
            {
                Token = tokenHandler.WriteToken(token),
                User = user
            };

            return loginRresponseDto;
        }
    
    }
}

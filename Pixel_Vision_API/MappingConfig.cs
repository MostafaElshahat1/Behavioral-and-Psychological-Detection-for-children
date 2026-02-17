using AutoMapper;
using Pixel_Vision_API.Models;
using Pixel_Vision_API.Models.DTOs.ParentStudntDTOs;
using Pixel_Vision_API.Models.DTOs.RoleDTOs;
using Pixel_Vision_API.Models.DTOs.UserDTOs;

namespace Pixel_Vision_API
{
    public class MappingConfig : Profile
    {
        public MappingConfig()
        {
            CreateMap<Role, RoleDto>().ReverseMap();
            CreateMap<Role, RoleCreateDto>().ReverseMap();
            CreateMap<Role, RoleUpdateDto>().ReverseMap();

            CreateMap<User, UserDto>().ReverseMap();
            CreateMap<User, UserCreateDto>().ReverseMap();
            CreateMap<User, UserUpdateDto>().ReverseMap();
            
            CreateMap<ParentStudent, ParentStudentDto>().ReverseMap();
        }
    }
}

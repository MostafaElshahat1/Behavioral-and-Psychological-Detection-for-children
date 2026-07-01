using Pixel_Vision_API.Models;

namespace Pixel_Vision_API.Repository.IRepository
{
    public interface IRoleRepository:IBaseRepository<Role>
    {
        Task<Role> UpdateAsync(Role entity);
    }
}

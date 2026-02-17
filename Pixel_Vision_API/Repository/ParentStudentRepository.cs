using Pixel_Vision_API.Data;
using Pixel_Vision_API.Models;
using Pixel_Vision_API.Repository.IRepository;

namespace Pixel_Vision_API.Repository
{
    public class ParentStudentRepository : BaseRepository<ParentStudent>, IParentStudentRepository
    {
        private readonly ApplicationDbContext _context;
        public ParentStudentRepository(ApplicationDbContext _context) 
            :base(_context)
        {
            this._context = _context;
        }
    }
}

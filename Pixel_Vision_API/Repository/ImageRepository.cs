using Pixel_Vision_API.Data;
using Pixel_Vision_API.Models;
using Pixel_Vision_API.Repository.IRepository;

namespace Pixel_Vision_API.Repository
{
    public class ImageRepository : BaseRepository<ImageBehaviorAnalysis> , IImageRepository
    {
        private readonly ApplicationDbContext _context;

        public ImageRepository(ApplicationDbContext context) : base(context)
        {
            _context = context;
        }
    }
}

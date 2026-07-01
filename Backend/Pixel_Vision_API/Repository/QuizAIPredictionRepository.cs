using Pixel_Vision_API.Data;
using Pixel_Vision_API.Models;
using Pixel_Vision_API.Repository.IRepository;

namespace Pixel_Vision_API.Repository
{
    public class QuizAIPredictionRepository : BaseRepository<QuizAIPrediction> , IQuizAIPredictionRepository
    {
        private readonly ApplicationDbContext _context;
        public QuizAIPredictionRepository(ApplicationDbContext _context)
            : base(_context)
        {
            this._context = _context;
        }
    }
}

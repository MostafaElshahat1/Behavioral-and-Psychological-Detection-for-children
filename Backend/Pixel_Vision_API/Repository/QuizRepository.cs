using Microsoft.EntityFrameworkCore;
using Pixel_Vision_API.Data;
using Pixel_Vision_API.Models;
using Pixel_Vision_API.Repository.IRepository;

namespace Pixel_Vision_API.Repository
{
    public class QuizRepository : BaseRepository<Quiz>, IQuizRepository
    {
        private readonly ApplicationDbContext _context;
        public QuizRepository(ApplicationDbContext _context) : base(_context)
        {
            this._context = _context;
        }
        public async Task<Quiz?> GetByIdAsync(int quizId)
        {
            var result = await _context.Quizzes
                .Include(q => q.Questions)
                    .ThenInclude(q => q.Options)
                .FirstOrDefaultAsync(q => q.Id == quizId);
            return result;
                //.FirstOrDefaultAsync(q => q.Id == quizId && q.IsActive);
        }
        public async Task<List<Quiz>> GetAllQuizesAsync()
        {
            return await _context.Quizzes
             .Include(q => q.Questions)
                 .ThenInclude(q => q.Options)
             .AsNoTracking()
             .Where(q => q.IsActive)
             .ToListAsync();
        }

    }
}

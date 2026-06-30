using Pixel_Vision_API.Data;
using Pixel_Vision_API.Models;
using Pixel_Vision_API.Repository.IRepository;

namespace Pixel_Vision_API.Repository
{
    public class StudentAnalysisRepository : BaseRepository<StudentAnalysis>, IStudentAnalysisRepository
    {
        private readonly ApplicationDbContext _context;

        public StudentAnalysisRepository(ApplicationDbContext context) : base(context)
        {
            _context = context;
        }
    }
}

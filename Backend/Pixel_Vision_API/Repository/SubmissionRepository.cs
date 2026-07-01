using Microsoft.EntityFrameworkCore;
using Pixel_Vision_API.Data;
using Pixel_Vision_API.Models;
using Pixel_Vision_API.Repository.IRepository;
using System;

namespace Pixel_Vision_API.Repository
{
    public class SubmissionRepository : BaseRepository<QuizSubmission>, ISubmissionRepository
    {
        private readonly ApplicationDbContext _context;

        public SubmissionRepository(ApplicationDbContext _context):base(_context)
        {
            this._context = _context;
        }
        public async Task<QuizSubmission?> GetWithAnswersAsync(int submissionId)
        {
            return await _context.QuizSubmissions
                .Include(s => s.Answers)
                    .ThenInclude(a => a.Question)
                .FirstOrDefaultAsync(s => s.Id == submissionId);
        }


    }


}

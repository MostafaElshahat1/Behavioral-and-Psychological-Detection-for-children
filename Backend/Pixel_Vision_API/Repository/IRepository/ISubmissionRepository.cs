using Pixel_Vision_API.Models;

namespace Pixel_Vision_API.Repository.IRepository
{
    public interface ISubmissionRepository : IBaseRepository<QuizSubmission>
    {
        Task<QuizSubmission?> GetWithAnswersAsync(int submissionId);
    }

}

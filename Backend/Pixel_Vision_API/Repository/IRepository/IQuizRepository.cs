using Pixel_Vision_API.Models;

namespace Pixel_Vision_API.Repository.IRepository
{
    public interface IQuizRepository : IBaseRepository<Quiz>
    {
        Task<Quiz?> GetByIdAsync(int quizId);
        Task<List<Quiz>> GetAllQuizesAsync();

    }
}

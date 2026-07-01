using Pixel_Vision_API.Models;
using Pixel_Vision_API.Models.DTOs.ReportDTOs;

namespace Pixel_Vision_API.Repository.IRepository
{
    public interface IWeeklyReportRepository: IBaseRepository<WeeklyReport>
    {
        Task PatchReportAsync(int id, ReportPatchDto dto);
    }
}

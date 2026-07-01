using Pixel_Vision_API.Models;

namespace Pixel_Vision_API.Services.IServices
{
    public interface IRiskCalculatorService
    {
        string CalculateRisk(WeeklyReport report);
    }

}

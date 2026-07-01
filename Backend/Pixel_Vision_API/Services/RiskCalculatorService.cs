using Pixel_Vision_API.Models;
using Pixel_Vision_API.Services.IServices;

namespace Pixel_Vision_API.Services
{
    public class RiskCalculatorService : IRiskCalculatorService
    {
        public string CalculateRisk(WeeklyReport report)
        {
            if (report.TotalImages == 0)
                return "Low";

            var sleepingPercentage =
                (double)report.SleepingCount / report.TotalImages * 100;
            
            var LookingBackPercentage =
                (double)report.LookingBackCount / report.TotalImages * 100;
            
            

            if (sleepingPercentage > 30 || LookingBackPercentage > 30 ||
                sleepingPercentage + LookingBackPercentage == 50)
                return "High";

            if (sleepingPercentage > 15 || LookingBackPercentage > 15 ||
                sleepingPercentage + LookingBackPercentage == 25)
                return "Medium";

            return "Low";
        }
    }

}

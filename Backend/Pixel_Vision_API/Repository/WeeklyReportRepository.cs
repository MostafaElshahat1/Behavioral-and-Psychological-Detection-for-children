using Microsoft.EntityFrameworkCore;
using Pixel_Vision_API.Data;
using Pixel_Vision_API.Models;
using Pixel_Vision_API.Models.DTOs.ReportDTOs;
using Pixel_Vision_API.Repository.IRepository;

namespace Pixel_Vision_API.Repository
{
    public class WeeklyReportRepository : BaseRepository<WeeklyReport> , IWeeklyReportRepository
    {
        private readonly ApplicationDbContext _context;
        public WeeklyReportRepository(ApplicationDbContext context) : base(context)
        {
            _context = context;
            
        }

        private static readonly string[] AllowedStatuses =
        {
            "Pending",
            "Approved",
            "Sent"
        };

        public async Task PatchReportAsync(int id, ReportPatchDto dto)
        {
            var report = await _context.WeeklyReports
                .FirstOrDefaultAsync(x => x.Id == id);

            if (report == null)
                throw new Exception("Report not found");

            if (!string.IsNullOrWhiteSpace(dto.RiskLevel))
            {
                report.RiskLevel = dto.RiskLevel;
            }
            
            if (!string.IsNullOrWhiteSpace(dto.Recomendation))
            {
                report.Recomendation = dto.Recomendation;
            }

            if (!string.IsNullOrWhiteSpace(dto.Status))
            {
                if (!AllowedStatuses.Contains(dto.Status))
                    throw new Exception("Invalid status value");

                if (dto.Status == "Approved" && report.Status != "Approved")
                {
                    await ApproveReportAsync(report);
                }
                else
                {
                    report.Status = dto.Status;
                }
            } 

            await _context.SaveChangesAsync();
        }

        private async Task ApproveReportAsync(WeeklyReport report)
        {
            report.Status = "Approved";
            report.ApprovedAt = DateTime.UtcNow;

            var snapshot = new ApprovedReport
            {
                WeeklyReportId = report.Id,
                StudentId = report.StudentId,
                WeekNumber = report.WeekNumber,
                TotalImages = report.TotalImages,
                SleepingCount = report.SleepingCount,
                LookingBackCount = report.LookingBackCount,
                HandRaisedCount = report.HandRaisedCount,
                LookingForwardCount = report.LookingForwardCount,
                StandingCount = report.StandingCount,
                ReadingCount = report.ReadingCount,
                WrittingCount = report.WrittingCount,
                AvgConfidence = report.AvgConfidence,
                RiskLevel = report.RiskLevel,
                ApprovedAt = DateTime.UtcNow
            };

            await _context.ApprovedReports.AddAsync(snapshot);
        }


    }
}

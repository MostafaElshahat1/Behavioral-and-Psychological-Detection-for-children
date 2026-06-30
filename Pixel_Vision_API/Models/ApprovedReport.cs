namespace Pixel_Vision_API.Models
{
    public class ApprovedReport
    {
        public int Id { get; set; }
        public int WeeklyReportId { get; set; }

        public int StudentId { get; set; }
        public int WeekNumber { get; set; }

        public int TotalImages { get; set; }
        public int SleepingCount { get; set; }
        public int LookingBackCount { get; set; }
        public int HandRaisedCount { get; set; }
        public int WrittingCount { get; set; }  //normal
        public int ReadingCount { get; set; }   //normal
        public int StandingCount { get; set; }  // normal
        public int LookingForwardCount { get; set; }
        public double AvgConfidence { get; set; }
        public string RiskLevel { get; set; } = null!;

        public DateTime ApprovedAt { get; set; }
    }

}

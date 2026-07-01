namespace Pixel_Vision_API.Models.DTOs.ReportDTOs
{
    public class ReportDto
    {
        public int Id { get; set; }

        public int StudentId { get; set; }
        public int WeekNumber { get; set; }

        public int TotalImages { get; set; }
        public int SleepingCount { get; set; }
        public int LookingBackCount { get; set; }// turning around
        public int HandRaisedCount { get; set; }
        public int WrittingCount { get; set; }  //normal
        public int ReadingCount { get; set; }   //normal
        public int StandingCount { get; set; }  // normal
        public int LookingForwardCount { get; set; } 

        public double AvgConfidence { get; set; }
        public string RiskLevel { get; set; } = "Low";
        public string Status { get; set; } = "Pending";
        public string Recomendation { get; set; } = "EVERYTHING IS OK!";

    }
}

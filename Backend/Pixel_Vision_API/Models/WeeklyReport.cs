namespace Pixel_Vision_API.Models
{
    public class WeeklyReport
    {
        public int Id { get; set; }
        public int StudentId { get; set; }
        public int WeekNumber { get; set; }

        public int TotalImages { get; set; }
        public int SleepingCount { get; set; }  // calc
        public int LookingBackCount { get; set; }   // calc
        public int HandRaisedCount { get; set; }//normal
        public int WrittingCount { get; set; }  //normal
        public int ReadingCount { get; set; }   //normal
        public int StandingCount { get; set; }  // normal
        public int LookingForwardCount { get; set; }

        //Emotion counters
        public int NeutralCount { get; set; }
        public int AngryCount { get; set; }
        public int SurpriseCount { get; set; }
        public int SadCount { get; set; }
        public int HappyCount { get; set; }

        public double AvgConfidence { get; set; }
        public string RiskLevel { get; set; } = "Low";

        public string Status { get; set; } = "Pending";
        public string Recomendation { get; set; } = "EVERYTHING IS OK!";
        public DateTime? ApprovedAt { get; set; }
        public byte[] RowVersion { get; set; } = null!; // Concurrency
    }

}

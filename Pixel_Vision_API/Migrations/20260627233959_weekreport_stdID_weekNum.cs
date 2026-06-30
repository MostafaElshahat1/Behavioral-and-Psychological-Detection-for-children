using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Pixel_Vision_API.Migrations
{
    /// <inheritdoc />
    public partial class weekreport_stdID_weekNum : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateIndex(
                name: "IX_WeeklyReports_StudentId_WeekNumber",
                table: "WeeklyReports",
                columns: new[] { "StudentId", "WeekNumber" },
                unique: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_WeeklyReports_StudentId_WeekNumber",
                table: "WeeklyReports");
        }
    }
}

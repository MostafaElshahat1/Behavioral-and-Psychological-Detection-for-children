using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Pixel_Vision_API.Migrations
{
    /// <inheritdoc />
    public partial class report_updated : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "LookingForwardCount",
                table: "WeeklyReports",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "ReadingCount",
                table: "WeeklyReports",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "StandingCount",
                table: "WeeklyReports",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "WrittingCount",
                table: "WeeklyReports",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "LookingForwardCount",
                table: "ApprovedReports",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "ReadingCount",
                table: "ApprovedReports",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "StandingCount",
                table: "ApprovedReports",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "WrittingCount",
                table: "ApprovedReports",
                type: "int",
                nullable: false,
                defaultValue: 0);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "LookingForwardCount",
                table: "WeeklyReports");

            migrationBuilder.DropColumn(
                name: "ReadingCount",
                table: "WeeklyReports");

            migrationBuilder.DropColumn(
                name: "StandingCount",
                table: "WeeklyReports");

            migrationBuilder.DropColumn(
                name: "WrittingCount",
                table: "WeeklyReports");

            migrationBuilder.DropColumn(
                name: "LookingForwardCount",
                table: "ApprovedReports");

            migrationBuilder.DropColumn(
                name: "ReadingCount",
                table: "ApprovedReports");

            migrationBuilder.DropColumn(
                name: "StandingCount",
                table: "ApprovedReports");

            migrationBuilder.DropColumn(
                name: "WrittingCount",
                table: "ApprovedReports");
        }
    }
}

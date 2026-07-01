using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Pixel_Vision_API.Migrations
{
    /// <inheritdoc />
    public partial class updated_report_with_emotion_counts : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "AngryCount",
                table: "WeeklyReports",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "HappyCount",
                table: "WeeklyReports",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "NeutralCount",
                table: "WeeklyReports",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "SadCount",
                table: "WeeklyReports",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "SurpriseCount",
                table: "WeeklyReports",
                type: "int",
                nullable: false,
                defaultValue: 0);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "AngryCount",
                table: "WeeklyReports");

            migrationBuilder.DropColumn(
                name: "HappyCount",
                table: "WeeklyReports");

            migrationBuilder.DropColumn(
                name: "NeutralCount",
                table: "WeeklyReports");

            migrationBuilder.DropColumn(
                name: "SadCount",
                table: "WeeklyReports");

            migrationBuilder.DropColumn(
                name: "SurpriseCount",
                table: "WeeklyReports");
        }
    }
}

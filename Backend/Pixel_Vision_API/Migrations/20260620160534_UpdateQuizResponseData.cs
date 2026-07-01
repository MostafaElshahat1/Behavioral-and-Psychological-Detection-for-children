using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Pixel_Vision_API.Migrations
{
    /// <inheritdoc />
    public partial class UpdateQuizResponseData : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "InterventionNeeded",
                table: "QuizAIPredictions");

            migrationBuilder.DropColumn(
                name: "Recommendation",
                table: "QuizAIPredictions");

            migrationBuilder.DropColumn(
                name: "RiskId",
                table: "QuizAIPredictions");

            migrationBuilder.DropColumn(
                name: "RiskLabel",
                table: "QuizAIPredictions");

            migrationBuilder.RenameColumn(
                name: "Status",
                table: "QuizAIPredictions",
                newName: "risk_level");

            migrationBuilder.RenameColumn(
                name: "ProbabilityScore",
                table: "QuizAIPredictions",
                newName: "risk_score");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "risk_score",
                table: "QuizAIPredictions",
                newName: "ProbabilityScore");

            migrationBuilder.RenameColumn(
                name: "risk_level",
                table: "QuizAIPredictions",
                newName: "Status");

            migrationBuilder.AddColumn<bool>(
                name: "InterventionNeeded",
                table: "QuizAIPredictions",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<string>(
                name: "Recommendation",
                table: "QuizAIPredictions",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<int>(
                name: "RiskId",
                table: "QuizAIPredictions",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<string>(
                name: "RiskLabel",
                table: "QuizAIPredictions",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");
        }
    }
}

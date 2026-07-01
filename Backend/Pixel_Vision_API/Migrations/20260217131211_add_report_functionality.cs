using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Pixel_Vision_API.Migrations
{
    /// <inheritdoc />
    public partial class add_report_functionality : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "StudentId",
                table: "ImageBehaviorAnalyses",
                type: "int",
                nullable: true,
                defaultValue: 0);

            migrationBuilder.CreateTable(
                name: "WeeklyReports",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    StudentId = table.Column<int>(type: "int", nullable: false),
                    WeekNumber = table.Column<int>(type: "int", nullable: false),
                    TotalImages = table.Column<int>(type: "int", nullable: false),
                    SleepingCount = table.Column<int>(type: "int", nullable: false),
                    LookingBackCount = table.Column<int>(type: "int", nullable: false),
                    HandRaisedCount = table.Column<int>(type: "int", nullable: false),
                    AvgConfidence = table.Column<double>(type: "float", nullable: false),
                    RiskLevel = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Status = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    RowVersion = table.Column<byte[]>(type: "rowversion", rowVersion: true, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_WeeklyReports", x => x.Id);
                });

            migrationBuilder.CreateIndex(
                name: "IX_ImageBehaviorAnalyses_StudentId",
                table: "ImageBehaviorAnalyses",
                column: "StudentId");

            migrationBuilder.AddForeignKey(
                name: "FK_ImageBehaviorAnalyses_Users_StudentId",
                table: "ImageBehaviorAnalyses",
                column: "StudentId",
                principalTable: "Users",
                principalColumn: "ID",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_ImageBehaviorAnalyses_Users_StudentId",
                table: "ImageBehaviorAnalyses");

            migrationBuilder.DropTable(
                name: "WeeklyReports");

            migrationBuilder.DropIndex(
                name: "IX_ImageBehaviorAnalyses_StudentId",
                table: "ImageBehaviorAnalyses");

            migrationBuilder.DropColumn(
                name: "StudentId",
                table: "ImageBehaviorAnalyses");
        }
    }
}

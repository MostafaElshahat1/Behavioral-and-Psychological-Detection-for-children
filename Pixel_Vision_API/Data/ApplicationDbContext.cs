using Microsoft.EntityFrameworkCore;
using Pixel_Vision_API.Models;

namespace Pixel_Vision_API.Data
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
            :base(options)
        {
            
        }
        public DbSet<Role> Roles { get; set; }
        public DbSet<User> Users { get; set; }
        public DbSet<ParentStudent> ParentStudents { get; set; }
        public DbSet<Quiz> Quizzes { get; set; }
        public DbSet<Question> Questions { get; set; }
        public DbSet<Option> Options { get; set; }
        public DbSet<QuizSubmission> QuizSubmissions { get; set; }
        public DbSet<Answer> Answers { get; set; }
        public DbSet<ImageBehaviorAnalysis> ImageBehaviorAnalyses{ get; set; }
        public DbSet<QuizAIPrediction> QuizAIPredictions { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Question>()
                .HasIndex(q => q.FeatureKey)
                .IsUnique();

            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<ParentStudent>()
                .HasKey(ps => new { ps.ParentId, ps.StudentId });

            modelBuilder.Entity<ParentStudent>()
                .HasOne(ps => ps.Parent)
                .WithMany()
                .HasForeignKey(ps => ps.ParentId)
                .OnDelete(DeleteBehavior.Restrict);

            modelBuilder.Entity<ParentStudent>()
                .HasOne(ps => ps.Student)
                .WithMany()
                .HasForeignKey(ps => ps.StudentId)
                .OnDelete(DeleteBehavior.Restrict);
        }
    }
}

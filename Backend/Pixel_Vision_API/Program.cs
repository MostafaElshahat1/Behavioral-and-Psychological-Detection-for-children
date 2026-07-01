
using System.Text;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
using Pixel_Vision_API.Data;
using Pixel_Vision_API.Models;
using Pixel_Vision_API.Repository;
using Pixel_Vision_API.Repository.IRepository;
using Pixel_Vision_API.Services;
using Pixel_Vision_API.Services.IServices;

namespace Pixel_Vision_API
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);
            
            // Add CORS services
            builder.Services.AddCors(options =>
            {
                options.AddPolicy("AllowAll",
                    policy =>
                    {
                        policy
                            .AllowAnyOrigin()
                            .AllowAnyMethod()
                            .AllowAnyHeader();
                    });
            });
            // Add services to the container.
            builder.Services.AddDbContext<ApplicationDbContext>(option =>
            {
                option.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection"));
            });

            builder.Services.AddScoped<IRoleRepository, RoleRepository>();
            builder.Services.AddScoped<IUserRepository, UserRepository>();
            builder.Services.AddScoped<IQuizRepository, QuizRepository>();
            builder.Services.AddScoped<IQuestionRepository, QuestionRepository>();
            builder.Services.AddScoped<ISubmissionRepository, SubmissionRepository>();
            builder.Services.AddScoped<IImageRepository, ImageRepository>();
            builder.Services.AddScoped<IParentStudentRepository, ParentStudentRepository>();
            builder.Services.AddScoped<IWeeklyReportRepository,WeeklyReportRepository>();
            builder.Services.AddScoped<IMlService, MlService>();
            builder.Services.AddScoped<IRiskCalculatorService, RiskCalculatorService>();
            builder.Services.AddScoped<IQuizAIPredictionRepository, QuizAIPredictionRepository>();
            builder.Services.AddScoped<IStudentAnalysisRepository, StudentAnalysisRepository>();
            //builder.Services.AddHttpClient<IMlService, MlService>();

            builder.Services.AddAutoMapper(typeof(MappingConfig));

            builder.Services.AddHttpClient("QuizAiService", client =>
            {
                client.BaseAddress = new Uri("https://mostafaelshahat1-mental-health-risk-api.hf.space/predict"); // FastAPI URL
                client.Timeout = TimeSpan.FromSeconds(30);
            });
            builder.Services.AddHttpClient("ImageAiService", client =>
            {
                client.BaseAddress = new Uri("https://mostafaelshahat1-behaviormodel.hf.space/predict-universal"); // FastAPI URL
                client.Timeout = TimeSpan.FromSeconds(30);
            });
            builder.Services.AddHttpClient("ViolenceAiService", client =>
            {
                client.BaseAddress = new Uri(""); // FastAPI URL
                client.Timeout = TimeSpan.FromSeconds(30);
            });
            builder.Services.AddHttpClient("EmotionAiService", client =>
            {
                client.BaseAddress = new Uri("https://mostafaelshahat1-emotion-detection-yolo.hf.space/analyze"); // FastAPI URL
                client.Timeout = TimeSpan.FromSeconds(30);
            });
            builder.Services.AddHttpClient("recognition", client =>
            {
                client.BaseAddress = new Uri("https://ahmed-nn-face-recognition-api.hf.space/analyze"); // FastAPI URL
                client.Timeout = TimeSpan.FromMinutes(2);
            });
            builder.Services.AddHttpClient("emotion", client =>
            {
                client.BaseAddress = new Uri("https://mostafaelshahat1-emotion-detection-yolo.hf.space/analyze"); // FastAPI URL
                client.Timeout = TimeSpan.FromSeconds(30);
            });
            builder.Services.AddHttpClient("behavior", client =>
            {
                client.BaseAddress = new Uri("https://mostafaelshahat1-behaviormodel.hf.space/predict"); // FastAPI URL
                client.Timeout = TimeSpan.FromSeconds(30);
            });



            var key = builder.Configuration.GetValue<string>("ApiSettings:Secret");
            builder.Services.AddAuthentication(x =>
            {
                x.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
                x.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
            }).AddJwtBearer(x =>
            {
                x.RequireHttpsMetadata = false;
                x.SaveToken = true;
                x.TokenValidationParameters = new TokenValidationParameters
                {
                    ValidateIssuerSigningKey = true,
                    IssuerSigningKey = new SymmetricSecurityKey(Encoding.ASCII.GetBytes(key)),
                    ValidateIssuer = false,
                    ValidateAudience = false
                };
            });



            builder.Services.AddControllers();
            builder.Services.AddControllers(options =>
            {
                options.Filters.Add<ValidationFilter>();
            });
            // Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
            builder.Services.AddEndpointsApiExplorer();
            builder.Services.AddSwaggerGen(options =>
            {
                options.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme
                {
                    Description = 
                    "JWT Authorization header using Bearer scheme. \r\n\r\n " +
                    "Enter 'Bearer' [space] and then your token in the text input below.\r\n\r\n" +
                    "Example: \"Bearer 123456abcdef\"",
                    Name = "Authorization",
                    In = ParameterLocation.Header,
                    Scheme = "Bearer"
                });
                options.AddSecurityRequirement(new OpenApiSecurityRequirement
                {
                    {
                        new OpenApiSecurityScheme
                        {
                            Reference = new OpenApiReference
                            {
                                Type = ReferenceType.SecurityScheme,
                                Id = "Bearer"
                            },
                            Scheme = "oauth2",
                            Name = "Bearer",
                            In = ParameterLocation.Header
                        },
                        new List<string>()
                    }
                });
            });

            var app = builder.Build();

            // Enable CORS
            app.UseCors("AllowAll");

            // Configure the HTTP request pipeline.
            //if (app.Environment.IsDevelopment())
            //{
            app.UseSwagger();
                app.UseSwaggerUI();
            //}

            app.UseHttpsRedirection();

            app.UseAuthentication();
            app.UseAuthorization();


            app.MapControllers();

            app.Run();
        }
    }
}

using Clima_BackEnd.Models;
using Microsoft.EntityFrameworkCore;

namespace Clima_BackEnd.DataBaseContext
{
    public class ClimaDbContext : DbContext
    {
        public ClimaDbContext(DbContextOptions<ClimaDbContext> options) : base(options)
        {
        }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            var configuration = new ConfigurationBuilder()
             .SetBasePath(Directory.GetCurrentDirectory())
             .AddJsonFile("appsettings.json")
             .Build();

            var connectionString = configuration.GetConnectionString("DefaultConnection");
            optionsBuilder.UseSqlServer(connectionString);
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
        }

        //entities
        public DbSet<WeatherDataModel> Weathers { get; set; }
    }
}

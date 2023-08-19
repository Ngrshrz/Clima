using Clima_BackEnd.DataBaseContext;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();

var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
builder.Services.AddDbContext<ClimaDbContext>(x => x.UseSqlServer(connectionString));
builder.Services.AddHttpClient();

// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

//using (var scope = app.Services.CreateScope())
//{
//    var dbContext = scope.ServiceProvider.GetRequiredService<ClimaDbContext>();
//    dbContext.Database.EnsureCreated();
//}

// Configure the HTTP request pipeline.
app.UseSwagger();
app.UseSwaggerUI();



app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();

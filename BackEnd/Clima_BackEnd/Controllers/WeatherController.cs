using Clima_BackEnd.DataBaseContext;
using Clima_BackEnd.Models;
using Clima_BackEnd.Models.ApiModels;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Net.Http.Headers;
using System.Globalization;
using System.Text.Json;

namespace Clima_BackEnd.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class WeatherController : ControllerBase
    {
        private readonly IHttpClientFactory _httpClientFactory;
        private readonly ClimaDbContext _context;
        private ILogger<WeatherController> _logger;
        const string apiKey = "26905d293d6915645d8591d3fa27c2e2";
        const string openWeatherMapUrl = "https://api.openweathermap.org/data/2.5/weather";

        public WeatherController(ILogger<WeatherController> logger,
                                 IHttpClientFactory httpClientFactory,
                                 ClimaDbContext context)
        {
            _httpClientFactory = httpClientFactory;
            _context = context;
            _logger = logger;
        }

        [HttpGet("GetLocationWeather")]
        public async Task<IActionResult> GetLocationWeather([FromQuery] Coordinate coordinate)
        {
            try
            {
                var httpRequestMessage = new HttpRequestMessage(
                        HttpMethod.Get,
                        openWeatherMapUrl + "?units=metric" +
                        "&lat=" + coordinate.Latitude.ToString() +
                        "&lon=" + coordinate.Longitude.ToString() +
                        "&appid=" + apiKey);

                var httpClient = _httpClientFactory.CreateClient();
                var httpResponseMessage = await httpClient.SendAsync(httpRequestMessage);

                if (httpResponseMessage.IsSuccessStatusCode)
                {
                    using var contentStream =
                        await httpResponseMessage.Content.ReadAsStreamAsync();

                    var result =
                        await JsonSerializer.DeserializeAsync<WeatherResult>(contentStream);

                    if (result == null)
                        return BadRequest();

                    var record = new WeatherDataModel()
                    {
                        Latitude = result.coord.lat,
                        Longitude = result.coord.lon,
                        CityName = result.name != null ? result.name : "",
                        CountryName = result.sys != null ? result.sys.country : "",
                        Temperature = result.main != null ? result.main.temp : 0,
                        RegisterDate = DateTime.Now
                    };

                    await _context.AddAsync(record);
                    await _context.SaveChangesAsync();

                    return Ok(result);
                }
                return BadRequest();
            }
            catch (Exception ex)
            {
                return BadRequest(ex);
            }

        }

        [HttpGet("GetCityWeather")]
        public async Task<IActionResult> GetCityWeather(string cityName)
        {
            try
            {
                var httpRequestMessage = new HttpRequestMessage(
                        HttpMethod.Get,
                        openWeatherMapUrl +
                        "?q=" + cityName +
                        "&appid=" + apiKey +
                        "&units=metric");

                var httpClient = _httpClientFactory.CreateClient();
                var httpResponseMessage = await httpClient.SendAsync(httpRequestMessage);

                if (httpResponseMessage.IsSuccessStatusCode)
                {
                    using var contentStream =
                        await httpResponseMessage.Content.ReadAsStreamAsync();

                    var result =
                        await JsonSerializer.DeserializeAsync<WeatherResult>(contentStream);

                    if (result == null)
                        return BadRequest();

                    var record = new WeatherDataModel()
                    {
                        Latitude = result.coord.lat,
                        Longitude = result.coord.lon,
                        CityName = result.name != null ? result.name : "",
                        CountryName = result.sys != null ? result.sys.country : "",
                        Temperature = result.main != null ? result.main.temp : 0,
                        RegisterDate = DateTime.Now
                    };

                    await _context.AddAsync(record);
                    await _context.SaveChangesAsync();


                    return Ok(result);
                }
                return BadRequest();
            }
            catch (Exception ex)
            {
                return BadRequest(ex);
            }
        }

        [HttpGet("GetHistory")]
        public IActionResult GetHistory()
        {
            try
            {
                PersianCalendar pc = new PersianCalendar();
                var result = _context.Weathers.OrderByDescending(c => c.Id).Take(10).ToList();
                foreach (var item in result)
                {
                    var dateTime = item.RegisterDate;
                    item.RegisterDate = new DateTime(
                        pc.GetYear(dateTime),
                        pc.GetMonth(dateTime) ,
                        pc.GetDayOfMonth(dateTime),
                        TimeZoneInfo.ConvertTime(dateTime, TimeZoneInfo.FindSystemTimeZoneById("Iran Standard Time")).AddHours(-1).Hour,
                        TimeZoneInfo.ConvertTime(dateTime, TimeZoneInfo.FindSystemTimeZoneById("Iran Standard Time")).Minute,
                        TimeZoneInfo.ConvertTime(dateTime, TimeZoneInfo.FindSystemTimeZoneById("Iran Standard Time")).Second);
                }
                return Ok(result);
            }
            catch (Exception ex)
            {
                return BadRequest(ex);
            }
        }
    }
}
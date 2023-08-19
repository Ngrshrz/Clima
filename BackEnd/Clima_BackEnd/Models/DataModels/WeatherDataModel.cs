namespace Clima_BackEnd.Models
{
    public class WeatherDataModel
    {
        public long Id { get; set; }
        public double Latitude { get; set; }
        public double Longitude { get; set; }
        public double? Temperature { get; set; } // centigrade
        public string? CountryName { get; set; }
        public string? CityName { get; set; }
        public DateTime RegisterDate { get; set; }

    }
}



import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/utilities/constants.dart';

class Weather{

Future<dynamic> getlocationWeather()async{
      Location location = Location();
      await location.getCurrentLocation();
      NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapUrl/Weather/GetLocationWeather?Latitude=${location.latitude}&Longitude=${location.longitude}');
      var weatherData = await networkHelper.getData();
      return weatherData;
}
Future<dynamic> getCityWeather(String cityname) async{
  NetworkHelper networkHelper = NetworkHelper(
    '$openWeatherMapUrl/Weather/GetCityWeather?cityName=${cityname}'
  );
  var weatherData = await networkHelper.getData();
  return weatherData;
}
}
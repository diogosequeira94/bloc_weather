import 'package:flutter_weather_bloclib/feature_weather/data/models/weather_model.dart';
import 'package:flutter_weather_bloclib/feature_weather/data/network/weather_api_client.dart';
import 'package:meta/meta.dart';

abstract class WeatherRepository {
  Future<WeatherModel> fetchWeather(String city);
}

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherApiClient weatherApiClient;

  WeatherRepositoryImpl({
    @required this.weatherApiClient
  }) : assert(weatherApiClient != null);

  @override
  Future<WeatherModel> fetchWeather(String city) async {
    final int locationId = await weatherApiClient.getLocationId(city);
    return weatherApiClient.fetchWeather(locationId);
  }
}
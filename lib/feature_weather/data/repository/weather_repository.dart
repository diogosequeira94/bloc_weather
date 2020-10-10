import 'dart:convert';
import 'package:flutter_weather_bloclib/feature_weather/data/models/weather_model.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

abstract class WeatherRepository {
  Future<int> getLocationId(String city);
  Future<WeatherModel> fetchWeather(int locationId);
}

class WeatherRepositoryImpl implements WeatherRepository {
  static const baseUrl = 'https://www.metaweather.com';
  final http.Client httpClient;

  WeatherRepositoryImpl({
    @required this.httpClient
  }) : assert(httpClient != null);

  @override
  Future<int> getLocationId(String city) async {
    final locationUrl = '$baseUrl/api/location/search/?query=$city';
    final locationResponse = await httpClient.get(locationUrl);
    if(locationResponse.statusCode != 200){
      throw Exception('error getting locationId for city');
    }
    final locationJson = jsonDecode(locationResponse.body) as List;
    return(locationJson.first['woeid']);
  }

  @override
  Future<WeatherModel> fetchWeather(int locationId) async {
    final weatherUrl = '$baseUrl/api/location/$locationId';
    final weatherResponse = await httpClient.get(weatherUrl);
    if(weatherResponse.statusCode != 200) {
      throw Exception('error getting the weather for location');
    }
    final weatherJson = jsonDecode(weatherResponse.body);
    return WeatherModel.fromJson(weatherJson);
  }
}
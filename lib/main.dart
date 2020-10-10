import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_bloclib/app.dart';
import 'package:flutter_weather_bloclib/feature_weather/data/repository/weather_repository.dart';
import 'package:flutter_weather_bloclib/feature_weather/presentation/simple_bloc_observer.dart';
import 'package:http/http.dart' as http;

import 'feature_weather/data/network/weather_api_client.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  final WeatherRepositoryImpl weatherRepository = WeatherRepositoryImpl(
    weatherApiClient: WeatherApiClient(
      httpClient: http.Client(),
    ),
  );
  runApp(App());
}
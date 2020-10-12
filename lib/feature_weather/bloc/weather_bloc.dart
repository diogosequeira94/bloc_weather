import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_weather_bloclib/feature_weather/data/models/weather.dart';
import 'package:flutter_weather_bloclib/feature_weather/data/repository/repositories.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {

  final WeatherRepositoryImpl weatherRepositoryImpl;
  WeatherBloc({@required this.weatherRepositoryImpl}) : super(WeatherInitial());

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if(event is WeatherFetched) {
      yield WeatherLoading('Loading weather info...');
      try {
        final WeatherModel weatherModel = await weatherRepositoryImpl.fetchWeather(event.city);
        yield WeatherLoaded(weather: weatherModel);
      } catch (_) {
        yield WeatherLoadingFailure('Sorry! Unexpected problem occurred');
      }
    } else if(event is WeatherRefreshRequested){
      try {
        final WeatherModel weatherModel = await weatherRepositoryImpl.fetchWeather(event.city);
        yield WeatherLoaded(weather: weatherModel);
      } catch (_) {
        yield WeatherLoadingFailure('Error updating info!');
      }
    }
  }
}

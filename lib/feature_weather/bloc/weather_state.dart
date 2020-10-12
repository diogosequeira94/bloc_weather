part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();
}

class WeatherInitial extends WeatherState {
  @override
  List<Object> get props => [];
}

class WeatherLoading extends WeatherState {
  final String message;
  const WeatherLoading(this.message);

  @override
  List<Object> get props => [message];
}

class WeatherLoaded extends WeatherState {
  final WeatherModel weather;
  const WeatherLoaded({@required this.weather}) : assert(weather != null);

  @override
  List<Object> get props => [weather];
}

class WeatherLoadingFailure extends WeatherState {
  final String message;
  const WeatherLoadingFailure(this.message);

  @override
  List<Object> get props => [message];
}



part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class WeatherFetched extends WeatherEvent {
  final String city;

  const WeatherFetched({@required this.city}) : assert(city != null);

  @override
  List<Object> get props => [city];
}

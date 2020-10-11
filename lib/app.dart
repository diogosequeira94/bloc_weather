import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_bloclib/feature_weather/data/repository/repositories.dart';
import 'file:///C:/Users/ctw01015/Desktop/Training%20Projects/flutter_weather_bloclib/lib/feature_weather/presentation/pages/weather_display_screen.dart';

import 'feature_weather/bloc/weather_bloc.dart';

class App extends StatelessWidget {
  final WeatherRepositoryImpl weatherRepository;

  App({Key key, @required this.weatherRepository})
      : assert(weatherRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Weather',
      home: BlocProvider(
        create: (context) =>
            WeatherBloc(weatherRepositoryImpl: weatherRepository),
        child: WeatherDisplayScreen(),
      ),
    );
  }
}
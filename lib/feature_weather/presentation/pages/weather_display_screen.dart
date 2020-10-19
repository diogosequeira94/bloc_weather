import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_bloclib/feature_weather/bloc/bloc.dart';
import 'package:flutter_weather_bloclib/feature_weather/presentation/widgets/location_widget.dart';
import 'package:flutter_weather_bloclib/feature_weather/presentation/widgets/widgets.dart';
import 'dart:async';
import 'city_selection_screen.dart';

class WeatherDisplayScreen extends StatefulWidget {
  @override
  _WeatherDisplayScreenState createState() => _WeatherDisplayScreenState();
}

class _WeatherDisplayScreenState extends State<WeatherDisplayScreen> {
  // Refresh Indicator
  Completer<void> _refreshCompleter;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Bloc App'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final city = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CitySelectionScreen(),
                ),
              );
              if (city != null) {
                BlocProvider.of<WeatherBloc>(context)
                    .add(WeatherFetched(city: city));
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF1e2d47),
                    Color(0xFF283c5f),
                    Color(0xFF324b77),
                    Color(0xFF3c598e),
                    Color(0xFF4668a6),
                    Color(0xFF5077be),
                  ])),
          child: BlocConsumer<WeatherBloc, WeatherState>(
            listener: (context, state){
              if(state is WeatherLoaded) {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('Hello!'),
                ));
              }
            },
            builder: (context, state) {
              if (state is WeatherInitial) {
                return Center(
                  child: Text('Please select a location',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0
                    ),
                  ),
                );
              }
              if (state is WeatherLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is WeatherLoaded) {
                final weather = state.weather;
                return RefreshIndicator(
                  onRefresh: () {
                    BlocProvider.of<WeatherBloc>(context).add(
                      WeatherRefreshRequested(city: state.weather.location),
                    );
                    return _refreshCompleter.future;
                  },
                  child: ListView(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 50.0),
                        child: Center(
                          child: LocationWidget(location: weather.location),
                        ),
                      ),
                      Center(
                        child: LastUpdatedWidget(dateTime: weather.lastUpdated),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 50.0),
                        child: Center(
                          child: CombinedWeatherTemperature(
                            weather: weather,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              if (state is WeatherLoadingFailure) {
                return Text(
                  state.message,
                  style: TextStyle(color: Colors.red),
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}

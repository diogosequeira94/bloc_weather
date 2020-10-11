import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_bloclib/feature_weather/bloc/bloc.dart';
import 'package:flutter_weather_bloclib/feature_weather/presentation/pages/city_selection_screen.dart';
import 'package:flutter_weather_bloclib/feature_weather/presentation/widgets/location.dart';

class WeatherDisplayScreen extends StatelessWidget {
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
              if(city != null){
                BlocProvider.of<WeatherBloc>(context)
                    .add(WeatherFetched(city: city));
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: (){},
          ),
        ],
      ),
      body: Center(
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state){
            if(state is WeatherInitial){
              return Center(
                child: Text('Please select a location'),
              );
            } else if (state is WeatherLoading){
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WeatherLoaded){
              final weather = state.weather;
              return ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 100.0),
                    child: Center(
                      child: Location(location: weather.location),
                    ),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

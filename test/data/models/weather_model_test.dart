import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_bloclib/feature_weather/data/models/weather.dart';

void main() {
  group('Weather', () {
    final weatherModel = WeatherModel(
      condition: WeatherCondition.clear,
      formattedCondition: 'Clear',
      minTemp: 20,
      maxTemp: 40,
      locationId: 0,
      location: 'Lisbon',
      lastUpdated: DateTime(2019),
    );

    test('props are correct', () {
      expect(weatherModel.props, [
        WeatherCondition.clear,
        'Clear',
        15,
        null,
        20,
        0,
        null,
        DateTime(2019),
        'Lisbon',
      ]);
    });

    test('fromJSON return correct wheater', () {
      final json = {
        "consolidated_weather": [
          {
            "weather_state_name": "Clear",
            "created": "2019-02-10T19:55:02.434940Z",
            "min_temp": 3.75,
            "max_temp": 6.883333333333333,
          },
        ],
        "woeid": 0,
      };

      final actual = WeatherModel.fromJson(json);
      expect(actual.locationId, 0);
      expect(actual.minTemp, 3.75);
      expect(actual.maxTemp, 6.883333333333333);
    });
  });
}

import 'package:clima/utilities/constants.dart';

import 'location.dart';
import 'networking.dart';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    String url = '$kOpenWeatherBaseUrl'
        'weather?q=$cityName'
        '&appid=$kWeatherApiKey'
        '&units=metric';

    NetworkHelper networkHelper = NetworkHelper(
      url: url,
    );

    return await networkHelper.getData();
  }

  Future<dynamic> getWeatherOfCurrentLocation() async {
    Location location = Location();
    await location.getLastLocation();

    NetworkHelper networkHelper = NetworkHelper(
      url: '$kOpenWeatherBaseUrl'
          'weather?lat=${location.latitude}'
          '&lon=${location.longitude}'
          '&appid=$kWeatherApiKey'
          '&units=metric',
    );

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}

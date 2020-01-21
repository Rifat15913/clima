import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../services/location.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude;
  double longitude;

  void getLocationData() async {
    Location location = Location();
    await location.getLastLocation();

    latitude = location.latitude;
    longitude = location.longitude;

    NetworkHelper networkHelper = NetworkHelper(
      url: 'https://api.openweathermap.org/data/2.5/'
          'weather?lat=$latitude&lon=$longitude&appid=$kWeatherApiKey',
    );

    var weatherData = await networkHelper.getData();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationScreen(
          locationWeather: weatherData,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          size: 80.0,
          color: Colors.white,
        ),
      ),
    );
  }
}

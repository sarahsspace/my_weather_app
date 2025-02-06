import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  //apikey 
  final _weatherService = WeatherService('3830a9b6d73ccb5b3f11fdf3fabc53d4');
  
  Weather? _weather;

  //fetch weather 
  _fetchWeather () async {
    //get curr city 
    String cityName = await _weatherService.getCurrentCity();

    //get weather for city 
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }
    catch (e) {
      print('Error fetching weather: $e');
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
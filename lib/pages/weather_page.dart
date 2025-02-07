import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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
  _fetchWeather() async {
    //get curr city
    String cityName = await _weatherService.getCurrentCity();

    //get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print('Error fetching weather: $e');
    }
  }

  //method for weather anim
  String getAnim(String? mainCond) {
    //def is sun
    switch (mainCond?.toLowerCase()) {
      case 'clouds':
      case 'haze':
      case 'fog':
      case 'mist':
      case 'dust':
      case 'smoke':
        return 'assets/cloudy.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rainy.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'clear':
      default:
        return 'assets/sunny.json';
    }
  }

  // init state for app startup
  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  // build UI for page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 174, 180, 184),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //city name and temp
            Text(
              _weather?.cityName ?? "Loading city...",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            //weather anims
            Lottie.asset(getAnim(_weather?.mainCond)),

            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "Temperature:\n",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: "${_weather?.temperature.round()}°C",
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 10), //like a spacer

            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "Feels like:\n", // 🔹 This part is bold
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text:
                        "${_weather?.feelsLike.round()} °C", // 🔹 Normal style
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center, // 🔹 Centers the whole text block
            ),

            const SizedBox(height: 10),
            // want anim mmatch cind so get it and set accordingly
            Text(
              _weather?.mainCond ?? "Loading main condition...",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

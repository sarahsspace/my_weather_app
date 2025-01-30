//for fetching the data from api ?

import 'dart:convert';

import 'package:geolocator/geolocator.dart';

import '../models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const BASE_URL = 'http://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeather(String cityName) async {
    final response = await http.get(Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metric'))

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to fetch weather data');
  }
}

 Future<String> getCurrentCity() async {
  //this is getting permission 
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }

  // now fetching locations 
  Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  final city = await Geolocator.reverseGeocode(position.latitude, position.longitude);

  return city.first.locality;
 }
}
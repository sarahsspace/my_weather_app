//for fetching the data from api ?

import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart'; //flutter pckg to get user loc

import '../models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const BASE_URL = 'http://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeather(String cityName) async {
    final response = await http
        .get(Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      print(" API RESP ${response.body}"); // Debugging
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }

//future returns value that will be avail in future here its a string
//and async func allows app to run w out this func blocking  it.
//await is used to wait for that part to complete b4 moving frwd
  Future<String> getCurrentCity() async {
    //this is getting permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    // now fetching locations
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    //getcurrpos converts GPS coordinates into a readable address

    //converts loc into list of placemark objects that represents a human-readable address from GPS coordinates.
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    //get city name form first placemark
    // string? means city can be null and city?? "" means an empty str ret if its null
    String? city = placemarks[0].locality;
    return city ?? "";
  }
}

import 'package:flutter/material.dart';
import 'pages/weather_page.dart';

void main() {
  runApp(const MyApp()); // starts app by calling MyApp()class 
  //so its flutters entry pt 
  //loads myapp widget first when it is loaded
}

class MyApp extends StatelessWidget { //root widget doesnt change overtime bcz stateless
  const MyApp({super.key}); 
//const is for performance and super.key is to manage widget state during ui updates
  @override
  Widget build(BuildContext context) { //build decribes the widgets ui 
    return const MaterialApp( //main flutter ui container
      debugShowCheckedModeBanner: false,
      home : WeatherPage(), //home first screen of app 
    );
  } 
}
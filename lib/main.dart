import 'package:flutter/material.dart';
import 'package:weather_app/home_screen.dart';
import 'package:weather_app/second_screen.dart';

void main(){
  runApp( const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      routes: {
        "/home":(context)=>SecondScreen(),
      },
    );
  }
}

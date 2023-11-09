import 'package:flutter/material.dart';
import 'package:weather_app/Theme/dark_theme.dart';
import 'package:weather_app/Theme/light_theme.dart';
import 'package:weather_app/pages/weather_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: lightThemeData,
      darkTheme: darkThemeData,
      home: const WeatherApp()
    );
  }
}

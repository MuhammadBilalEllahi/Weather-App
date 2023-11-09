import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/Modal/weather_modal.dart';
import 'package:weather_app/Service/weather_service.dart';

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {

  final _weatherService = WeatherService(api_key: '87c94f956a6a25172f83909a8cba7e8b' );
  WeatherModal? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getLocation();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      }); 
    } catch (e) {
      print(e); 
    }
  }

  String weatherCondition(String mainCondition)  {

    switch(mainCondition.toLowerCase()){
      case 'mist':
      case 'smoke':
                  return 'asset/smoke.json';
      case 'haze':
      case 'dust':
      case 'fog':
      case 'rain':
      case 'drizzle':
      case 'shower rain':
            return 'asset/sun_rain_cloud.json';
      case 'thunderstorm':
            return 'asset/thunder_cloud_rain.json';
      case 'clear':
            return 'asset/sun.json';
      case 'clouds':
            return 'asset/cloud.json';
      default: 
      return 'asset/cloud.json';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

             Padding(
               padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
               child: Icon(Icons.location_on, color: Colors.grey.shade600,),
             ),
            // const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(_weather?.cityName ?? "Loading City Name" , style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold
              ), ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 30, 10, 30),
              child: Lottie.asset(
                weatherCondition(_weather?.mainCondition ?? 'asset/cloud.json'), 
                height: 400,
                width: 350
            
                ),
            ),

            // _weather!.temperature.round() > 270 ? 
            // Text('${(_weather!.temperature.round() - 273.15).roundToDouble()}°C' ), //error was caused before of scpace at end of base url. thus it was giving temperature in kelvin
                        

            Padding(
              padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
              child: Text('${_weather?.temperature.round()}°C',  style: const TextStyle(
                fontSize: 70,
                fontWeight: FontWeight.w300
              ), ),
            ),
            const SizedBox(height: 2,),
            Text('${_weather?.mainCondition}', style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w300
              ), ), 

            

      
          ]
          ),
      ),
    );
  }
}
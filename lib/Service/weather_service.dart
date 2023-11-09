import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/Modal/weather_modal.dart';

class WeatherService {
  static const BASE_URL = "https://api.openweathermap.org/data/2.5/weather";
  final String api_key;

  WeatherService({
    required this.api_key
  });

  Future<WeatherModal> getWeather(String cityName) async{
    final response = await http.get(Uri.parse("$BASE_URL?q=$cityName&appid=$api_key&units=metric"));
      if(response.statusCode ==200){
        print(response.body);
        return WeatherModal.fromJson(jsonDecode(response.body));
      }
      else{
        throw Exception('Failed To load Data');
      }
  }

  Future<String> getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high
    );
    List<Placemark> placeMark =
     await placemarkFromCoordinates(position.latitude, position.longitude);

    String? city = placeMark[0].locality;
    print(city);

    return city ?? "";

  }
}
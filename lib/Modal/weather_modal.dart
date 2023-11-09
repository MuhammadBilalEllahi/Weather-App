class WeatherModal {
  final String cityName;
  final double temperature;
  final String mainCondition;
  
  


  WeatherModal({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,
  });

  factory WeatherModal.fromJson(Map<String, dynamic> json){

    return WeatherModal(
      cityName: json['name'], 
      temperature: json['main']['temp'].toDouble(), 
      mainCondition: json['weather'][0]['main'] , 
    );
  }


}
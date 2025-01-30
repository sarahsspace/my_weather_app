class Weather{
  final String cityName;
  final double temperature;
  //final double feelsLike;
  final String mainCond;

Weather( {
  required this.cityName, 
  required this.temperature, 
  //required this.feelsLike,
  required this.mainCond,});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      //feelsLike: json['main']['feels_like'],
      mainCond: json['weather'][0]['main'],
    );
  }
}
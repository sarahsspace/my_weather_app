class Weather {
  final String cityName; //vars cant change after obj creation
  final double temperature;
  final double feelsLike;
  final String mainCond;

  Weather({
    //named constructor
    required this.cityName,
    required this.temperature,
    required this.feelsLike,
    required this.mainCond,
  });

//factory constructor is used to create an instance from a JSON object.
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: (json['main']['temp'] ?? 0.0).toDouble(),
      feelsLike: (json['main']['feels_like'] ?? 0.0)
          .toDouble(), //handling nulls from api calls
      mainCond: json['weather'][0]['main'],
    );
  }
}

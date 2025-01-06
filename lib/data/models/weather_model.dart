class Weather {
  final String cityName;
  final double temperature;
  final int humidity;
  final String weatherDescription;
  final String icon;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.humidity,
    required this.weatherDescription,
    required this.icon,
  });

  @override
  String toString() {
  return 'Ville: $cityName, Température: $temperature°C, Humidité: $humidity%, Icône: $icon';
  }

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'],
      humidity: json['main']['humidity'],
      weatherDescription: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
    );
  }
}

class WeatherForecast {
  final String date;
  final double temperature;
  final int humidity;
  final String icon;
  final String description;

  WeatherForecast({
    required this.date,
    required this.temperature,
    required this.humidity,
    required this.icon,
    required this.description,
  });

  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    return WeatherForecast(
      date: json['dt_txt'],
      temperature: json['main']['temp'].toDouble(),
      humidity: json['main']['humidity'],
      icon: json['weather'][0]['icon'],
      description: json['weather'][0]['description'],
    );
  }
}

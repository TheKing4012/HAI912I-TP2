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

class Forecast {
  final DateTime date;
  final double temperature;
  final String weatherIcon;

  Forecast({
    required this.date,
    required this.temperature,
    required this.weatherIcon,
  });
}

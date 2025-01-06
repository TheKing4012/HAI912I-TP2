import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class WeatherRepository {
  final String apiKey = '2286385f3685c4a5b6490a7457d76883';

  Future<(Weather, List<WeatherForecast>)> fetchWeatherAndForecast(String cityName) async {
    // Récupérer la météo actuelle
    final currentResponse = await http.get(
      Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric',
      ),
    );

    // Récupérer les prévisions
    final forecastResponse = await http.get(
      Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&appid=$apiKey&units=metric',
      ),
    );

    if (currentResponse.statusCode == 200 && forecastResponse.statusCode == 200) {
      final currentJson = jsonDecode(currentResponse.body);
      final forecastJson = jsonDecode(forecastResponse.body);

      Weather currentWeather = Weather.fromJson(currentJson);

      // Filtrer pour avoir une prévision par jour
      List<WeatherForecast> forecasts = [];
      String currentDate = "";

      for (var item in forecastJson['list']) {
        String forecastDate = item['dt_txt'].toString().split(' ')[0];
        if (forecastDate != currentDate) {
          currentDate = forecastDate;
          forecasts.add(WeatherForecast.fromJson(item));
        }
        if (forecasts.length >= 4) break; // Limiter à 4 jours
      }

      return (currentWeather, forecasts);
    } else {
      throw Exception('Erreur lors de la récupération des données météo');
    }
  }
}

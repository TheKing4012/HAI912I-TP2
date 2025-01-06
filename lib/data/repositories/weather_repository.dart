import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class WeatherRepository {
  final String apiKey = '2286385f3685c4a5b6490a7457d76883'; // Remplace par ta clé API d'OpenWeatherMap.
  Future<Weather> fetchWeather(String cityName) async {
    print("Appel API pour la ville : $cityName");
    final response = await http.get(
      Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric',
      ),
    );

    if (response.statusCode == 200) {
      print("Réponse API : ${response.body}");
      final json = jsonDecode(response.body);
      Weather weather = Weather.fromJson(json);
      print(weather.temperature); // Vérifie que la température est bien extraite
      return weather;
    } else {
      print("Erreur API : ${response.statusCode}");
      print("Corps de la réponse : ${response.body}"); // Nouveau debug
      throw Exception('Erreur lors de la récupération des données météo');
    }
  }


}

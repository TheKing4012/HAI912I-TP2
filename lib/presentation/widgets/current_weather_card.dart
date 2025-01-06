import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../../data/models/weather_model.dart';

class CurrentWeatherCard extends StatelessWidget {
  final Weather weather;

  const CurrentWeatherCard({Key? key, required this.weather}) : super(key: key);

  String _getFormattedDate() {
    // Initialiser le formatage en français
    initializeDateFormatting('fr_FR', null);

    // Créer un formateur de date en français
    final dateFormatter = DateFormat.yMMMMEEEEd('fr_FR');

    // Obtenir la date actuelle et la formater
    final now = DateTime.now();
    // Première lettre en majuscule
    return dateFormatter.format(now)[0].toUpperCase() +
        dateFormatter.format(now).substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              weather.cityName,
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 10),
            Text(
              _getFormattedDate(),
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  'https://openweathermap.org/img/wn/${weather.icon}@2x.png',
                  height: 60,
                ),
                Text(
                  '${weather.temperature.round()}°C',
                  style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.water_drop, color: Colors.blue),
                const SizedBox(width: 5),
                Text(
                  'Humidité: ${weather.humidity}%',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
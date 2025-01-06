import 'package:flutter/material.dart';
import '../../data/models/weather_model.dart';

class CurrentWeatherCard extends StatelessWidget {
  final Weather weather;

  const CurrentWeatherCard({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          weather.cityName,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text('Température : ${weather.temperature}°C'),
        Text('Humidité : ${weather.humidity}%'),
        Text('Précipitations : ${weather.humidity}mm'),
        Image.network('https://openweathermap.org/img/wn/${weather.icon}.png'),
      ],
    );
  }
}

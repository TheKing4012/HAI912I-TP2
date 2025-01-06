import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/models/weather_model.dart';

class ForecastCard extends StatelessWidget {
  final WeatherForecast forecast;

  const ForecastCard({Key? key, required this.forecast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final date = DateTime.parse(forecast.date);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              '${date.day}/${date.month}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Image.network(
              'https://openweathermap.org/img/wn/${forecast.icon}.png',
              height: 50,
            ),
            Text('${forecast.temperature.round()}°C'),
            Text('${forecast.humidity}%'),
          ],
        ),
      ),
    );
  }
}
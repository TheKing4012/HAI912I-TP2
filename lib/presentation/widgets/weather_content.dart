import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/blocs/weather_bloc.dart';
import '../../business_logic/events/weather_event.dart';
import '../../business_logic/states/weather_state.dart';
import 'current_weather_card.dart';
import 'forecast_card.dart';

class WeatherContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
              labelText: 'Entrez une ville',
              border: OutlineInputBorder(),
            ),
            onSubmitted: (value) {
              context.read<WeatherBloc>().add(FetchWeather(value));
            },
          ),
          const SizedBox(height: 20),
          Expanded(
            child: BlocConsumer<WeatherBloc, WeatherState>(
              listener: (context, state) {
                if (state is WeatherError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context, state) {
                if (state is WeatherLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is WeatherLoaded) {
                  return Column(
                    children: [
                      CurrentWeatherCard(weather: state.currentWeather),
                      const SizedBox(height: 20),
                      const Text(
                        'Prévisions pour les prochains jours',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 180,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.forecast.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                              child: ForecastCard(
                                forecast: state.forecast[index],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
                if (state is WeatherError) {
                  return Center(child: Text(state.message));
                }
                return const Center(child: Text('Saisissez une ville.'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
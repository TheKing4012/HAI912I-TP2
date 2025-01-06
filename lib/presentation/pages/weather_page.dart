import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/blocs/weather_bloc.dart';
import '../../business_logic/events/weather_event.dart';
import '../../business_logic/states/weather_state.dart';
import '../../data/repositories/weather_repository.dart';
import '../widgets/current_weather_card.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherBloc(WeatherRepository()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Météo'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Entrez une ville',
                ),
                onSubmitted: (value) {
                  print("Ville saisie : $value"); // Debug
                  BlocProvider.of<WeatherBloc>(context).add(FetchWeather(value));
                },

              ),
              const SizedBox(height: 20),
              Expanded(
                child: BlocBuilder<WeatherBloc, WeatherState>(
                  builder: (context, state) {
                    if (state is WeatherInitial) {
                      return const Center(child: Text('Saisissez une ville.'));
                    } else if (state is WeatherLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is WeatherLoaded) {
                      return Center(child: CurrentWeatherCard(weather: state.weather));
                    } else if (state is WeatherError) {
                      return Center(child: Text(state.message));
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

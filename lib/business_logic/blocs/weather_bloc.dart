import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/weather_repository.dart';
import '../events/weather_event.dart';
import '../states/weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc(this.weatherRepository) : super(WeatherInitial()) {
    on<FetchWeather>((event, emit) async {
      print("Événement reçu pour la ville : ${event.cityName}"); // Debug
      emit(WeatherLoading());
      try {
        final (currentWeather, forecast) = await weatherRepository.fetchWeatherAndForecast(event.cityName);
        print("Données météo reçues : $currentWeather"); // Debug
        emit(WeatherLoaded(currentWeather, forecast));
      } catch (e) {
        print("Erreur : $e"); // Debug
        emit(WeatherError('Impossible de récupérer les données météo'));
      }
    });
  }
}


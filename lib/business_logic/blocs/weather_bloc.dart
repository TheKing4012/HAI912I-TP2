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
        final weather = await weatherRepository.fetchWeather(event.cityName);
        print("Données météo reçues : $weather"); // Debug
        emit(WeatherLoaded(weather));
      } catch (e) {
        print("Erreur : $e"); // Debug
        emit(WeatherError('Impossible de récupérer les données météo'));
      }
    });

  }
}

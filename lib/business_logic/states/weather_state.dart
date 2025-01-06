import '../../data/models/weather_model.dart';

abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final Weather currentWeather;
  final List<WeatherForecast> forecast;

  WeatherLoaded(this.currentWeather, this.forecast);
}

class WeatherError extends WeatherState {
  final String message;

  WeatherError(this.message);
}

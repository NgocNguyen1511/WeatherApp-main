part of 'weather_bloc_bloc.dart';

abstract class WeatherBlocEvent extends Equatable {
  const WeatherBlocEvent();

  factory WeatherBlocEvent.fetchWeather(Position position) = FetchWeather;
  factory WeatherBlocEvent.fetchTomorrowWeather(Position position) = FetchTomorrowWeather;

  @override
  List<Object> get props => [];
}

class FetchWeather extends WeatherBlocEvent {
  final Position position;

  const FetchWeather(this.position);

  @override
  List<Object> get props => [position];
}

class FetchTomorrowWeather extends WeatherBlocEvent {
  final Position position;

  const FetchTomorrowWeather(this.position);

  @override
  List<Object> get props => [position];
}
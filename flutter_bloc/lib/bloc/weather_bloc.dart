import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_example/data/weather_repository.dart';

import './bloc.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherBloc(this.weatherRepository) : super(WeatherInitial()) {
    on<GetWeather>((event, emit) async {
      try {
        final weather = await weatherRepository.fetchWeather(event.cityName);
        emit(WeatherLoaded(weather));
      } on NetworkError {
        emit(WeatherError("Couldn't fetch weather. Is the device online?"));
      }
    });

    on<GetDetailedWeather>((event, emit) async {
      try {
        final weather =
            await weatherRepository.fetchDetailedWeather(event.cityName);
        emit(WeatherLoaded(weather));
      } on NetworkError {
        emit(WeatherError("Couldn't fetch weather. Is the device online?"));
      }
    });
  }
}

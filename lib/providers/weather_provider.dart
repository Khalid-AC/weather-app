// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import 'package:weather_app/models/custom_error.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/repository/weather_repository.dart';

enum WeatherStatus {
  initial,
  loading,
  loaded,
  error,
}

class WeatherState extends Equatable {
  final WeatherStatus weatherStatus;
  final Weather weather;
  final CustomError error;

  //
  const WeatherState({
    required this.weatherStatus,
    required this.weather,
    required this.error,
  });

  //
  factory WeatherState.initial() {
    return WeatherState(
        weatherStatus: WeatherStatus.initial,
        weather: Weather.initial(),
        error: const CustomError());
  }

  @override
  List<Object> get props => [weatherStatus, weather, error];

  WeatherState copyWith({
    WeatherStatus? weatherStatus,
    Weather? weather,
    CustomError? error,
  }) {
    return WeatherState(
      weatherStatus: weatherStatus ?? this.weatherStatus,
      weather: weather ?? this.weather,
      error: error ?? this.error,
    );
  }

  @override
  bool get stringify => true;
}

class WeatherProvider with ChangeNotifier {
  WeatherState _state = WeatherState.initial();
  WeatherState get state => _state;

  final WeatherRepository weatherRepository;
  WeatherProvider({
    required this.weatherRepository,
  });

  Future<void> fetchWeather(String cityName) async {
    _state = _state.copyWith(weatherStatus: WeatherStatus.loading);
    notifyListeners();

    try {
      final Weather weather = await weatherRepository.fetchWeather(cityName);

      _state = _state.copyWith(
          weatherStatus: WeatherStatus.loaded, weather: weather);

      print(_state);
      notifyListeners();
    } on CustomError catch (e) {
      _state = _state.copyWith(weatherStatus: WeatherStatus.error, error: e);
      notifyListeners();
    }
  }
}

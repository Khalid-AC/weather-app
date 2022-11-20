// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  //
  final int weatherId;
  final String weatherMain;
  final String weatherDescription;
  final String cityName;
  // final double maxTemp;
  // final double minTemp;
  final double mainTemp;
  final String icon;
  final DateTime lastUpdated;
  const Weather({
    required this.weatherId,
    required this.weatherMain,
    required this.weatherDescription,
    required this.cityName,
    // required this.maxTemp,
    // required this.minTemp,
    required this.mainTemp,
    required this.icon,
    required this.lastUpdated,
  });

  factory Weather.fromjson(Map<String, dynamic> json) {
    return Weather(
        weatherId: json["weather"][0]["id"],
        weatherMain: json["weather"][0]["main"],
        weatherDescription: json["weather"][0]["description"],
        cityName: json["name"],
        // maxTemp: json["daily"]["temp"]["max"],
        // minTemp: json["daily"]["temp"]["min"],
        mainTemp: json["main"]["temp"],
        icon: json["weather"][0]["icon"],
        lastUpdated: DateTime.now());
  }

  factory Weather.initial() => Weather(
      weatherId: -1,
      weatherMain: "",
      weatherDescription: "",
      cityName: "",
      mainTemp: 100.00,
      // maxTemp: 100.00,
      // minTemp: 100.00,
      icon: "",
      lastUpdated: DateTime(1970));

  @override
  // TODO: implement props
  List<Object> get props {
    return [
      weatherId,
      weatherMain,
      weatherDescription,
      cityName,
      // maxTemp,
      // minTemp,
      mainTemp,
      icon,
      lastUpdated,
    ];
  }

  //

  Weather copyWith({
    int? weatherId,
    String? weatherMain,
    String? weatherDescription,
    String? cityName,
    double? maxTemp,
    double? minTemp,
    double? mainTemp,
    String? icon,
    DateTime? lastUpdated,
  }) {
    return Weather(
      weatherId: weatherId ?? this.weatherId,
      weatherMain: weatherMain ?? this.weatherMain,
      weatherDescription: weatherDescription ?? this.weatherDescription,
      cityName: cityName ?? this.cityName,
      // maxTemp: maxTemp ?? this.maxTemp,
      // minTemp: minTemp ?? this.minTemp,
      mainTemp: mainTemp ?? this.mainTemp,
      icon: icon ?? this.icon,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  @override
  bool get stringify => true;
}

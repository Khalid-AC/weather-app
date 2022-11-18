// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  //
  final int weatherId;
  final String weatherMain;
  final String weatherDescription;
  final double mainTemp;
  final DateTime lastUpdated;
  const Weather({
    required this.weatherId,
    required this.weatherMain,
    required this.weatherDescription,
    required this.mainTemp,
    required this.lastUpdated,
  });

  @override
  // TODO: implement props
  List<Object> get props {
    return [
      weatherId,
      weatherMain,
      weatherDescription,
      mainTemp,
      lastUpdated,
    ];
  }

  //

  Weather copyWith({
    int? weatherId,
    String? weatherMain,
    String? weatherDescription,
    double? mainTemp,
    DateTime? lastUpdated,
  }) {
    return Weather(
      weatherId: weatherId ?? this.weatherId,
      weatherMain: weatherMain ?? this.weatherMain,
      weatherDescription: weatherDescription ?? this.weatherDescription,
      mainTemp: mainTemp ?? this.mainTemp,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  @override
  bool get stringify => true;

  //
  factory Weather.fromjson(Map<String, dynamic> json) {
    return Weather(
        weatherId: json["weather"][0]["id"],
        weatherMain: json["weather"][0]["main"],
        weatherDescription: json["weather"][0]["description"],
        mainTemp: json["main"]["temp"],
        lastUpdated: DateTime.now());
  }

  factory Weather.initial() => Weather(
      weatherId: -1,
      weatherMain: "",
      weatherDescription: "",
      mainTemp: 100.00,
      lastUpdated: DateTime(1970));
}

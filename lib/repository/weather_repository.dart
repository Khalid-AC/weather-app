// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:weather_app/exceptions/weather_exception.dart';
import 'package:weather_app/models/custom_error.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/services/weather_api_services.dart';

class WeatherRepository {
  final WeatherApiServices weatherApiServices;
  WeatherRepository({
    required this.weatherApiServices,
  });

  Future<Weather> fetchWeather(String cityName) async {
    try {
      final List<double> latLon = await weatherApiServices.getCity(cityName);
      print("city : $latLon");

      final Weather weather = await weatherApiServices.getWeather(latLon);
      print("weather : $Weather");

      return weather;
    } on WeatherException catch (e) {
      throw CustomError(errMsg: e.message);
    } catch (e) {
      throw CustomError(errMsg: e.toString());
    }
  }
}

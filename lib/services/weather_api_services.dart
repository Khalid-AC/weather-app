// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import "package:http/http.dart" as http;
import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/exceptions/weather_exception.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/services/http_error_handler.dart';

class WeatherApiServices {
  final http.Client httpClient;
  WeatherApiServices({
    required this.httpClient,
  });

  Future<List<double>> getCity(String cityName) async {
    
    /*Uri uri = Uri(
        //scheme: "https",
        host: kHost,
        path: "/geo/1.0/direct?",
        queryParameters: {
          "q": cityName,
          "limit": 1,
          "appid": apiKey,
        });*/

    
    try {
      final http.Response response = await http.get(Uri.parse(
          "http://api.openweathermap.org/geo/1.0/direct?q=$cityName&limit=1&appid=$apiKey"));

      if (response.statusCode != 200) {
        throw httpErrorHandler(response);
      }

      //
      final List<dynamic> responseBody = json.decode(response.body);
      

      if (responseBody.isEmpty) {
        throw WeatherException(
            message: "Cannot get the informations of $cityName ");
      }
      if (responseBody.length > 1) {
        throw WeatherException(
            message:
                "There are multiple candidates for city, please specify one ");
      }

      return [responseBody[0]["lat"], responseBody[0]["lon"]];
    } catch (e) {
      rethrow;
    }
  }

  Future<Weather> getWeather(List<double> latLon) async {
    /*final Uri uri = Uri(
        scheme: "https",
        host: kHost,
        path: "/data/2.5/weather",
        queryParameters: {
          "lat": latLon[0],
          "lon": latLon[1],
          "apikey": apiKey
        });*/

    try {
      final http.Response response = await http.get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?lat=${latLon[0]}&lon=${latLon[1]}&appid=$apiKey"));

        

      if (response.statusCode != 200) {
        throw Exception(httpErrorHandler(response));
      }

      final weatherJson = json.decode(response.body);

      final Weather weather = Weather.fromjson(weatherJson);

      

      return weather;
    } catch (e) {
      rethrow;
    }
  }
}

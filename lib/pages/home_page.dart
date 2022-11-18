import 'dart:io';

import 'package:flutter/material.dart';
import 'package:weather_app/repository/weather_repository.dart';
import 'package:weather_app/services/weather_api_services.dart';
import "package:http/http.dart" as http;

class Homepage extends StatefulWidget {
  Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  _fetchCity() {
    WeatherApiServices(httpClient: http.Client()).getCity("London");
  }

  _fetchWeather() {
    WeatherRepository(
            weatherApiServices: WeatherApiServices(httpClient: http.Client()))
        .fetchWeather("London");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Weather"),
        ),
        body: Center(
          child: Text("Home"),
        ));
  }
}

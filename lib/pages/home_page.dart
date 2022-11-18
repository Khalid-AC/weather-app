import 'package:flutter/material.dart';
import 'package:weather_app/providers/weather_provider.dart';
import "package:http/http.dart" as http;

import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    _fetchWeather();
    super.initState();
    
  }

  _fetchWeather() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<WeatherProvider>().fetchWeather("London");
    });
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

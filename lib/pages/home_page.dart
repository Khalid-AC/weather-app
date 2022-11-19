import 'package:flutter/material.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/pages/search_page.dart';
import 'package:weather_app/providers/weather_provider.dart';
import "package:http/http.dart" as http;

import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  //
  String? _city;
  late final WeatherProvider _weatherProvider;

  @override
  void initState() {
    super.initState();
    _weatherProvider = context.read<WeatherProvider>();
    _weatherProvider.addListener(_registerListener);
  }

  @override
  void dispose() {
    _weatherProvider.removeListener(_registerListener);
    super.dispose();
  }

  void _registerListener() {
    final WeatherState ws = context.read<WeatherProvider>().state;

    if (ws.weatherStatus == WeatherStatus.error) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(content: Text(ws.error.errMsg));
          });
    }
  }

  /*
  @override
  void initState() {
    _fetchWeather();
    super.initState();
  }

  _fetchWeather() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<WeatherProvider>().fetchWeather("London");
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Weather"),
          actions: [
            IconButton(
                onPressed: () async {
                  _city = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return Searchpage();
                      },
                    ),
                  );

                  if (_city != null) {
                    context.read<WeatherProvider>().fetchWeather(_city!);
                  }
                  _city = null;
                },
                icon: const Icon(Icons.search))
          ],
        ),
        body: _showWeather());
  }

  Widget _showWeather() {
    final weatherState = context.watch<WeatherProvider>().state;

    if (weatherState.weatherStatus == WeatherStatus.initial) {
      return const Center(
          child: Text("Selec a city", style: TextStyle(fontSize: 20.0)));
    }

    if (weatherState.weatherStatus == WeatherStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if(weatherState.weatherStatus == WeatherStatus.error && weatherState.weather.cityName == ""){
      return const Center(
          child: Text("Select a city", style: TextStyle(fontSize: 20.0)));
    }

    return Center(
        child: Text(
      weatherState.weather.cityName,
      style: const TextStyle(fontSize: 18.0),
    ));
  }
}

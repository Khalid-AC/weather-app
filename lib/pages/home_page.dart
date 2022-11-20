import 'package:flutter/material.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/pages/search_page.dart';
import 'package:weather_app/pages/settings_page.dart';
import 'package:weather_app/providers/temp_settings_provider.dart';
import 'package:weather_app/providers/weather_provider.dart';
import "package:http/http.dart" as http;

import 'package:provider/provider.dart';
import 'package:weather_app/widgets/error_dialog.dart';

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
      errorDialog(context, ws.error.errMsg);
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
        //backgroundColor: Colors.white70,
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
              icon: const Icon(Icons.search),
            ),

            //
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const Settingspage();
                }));
              },
              icon: const Icon(Icons.settings),
            ),
          ],
        ),
        body: _showWeather());
  }

  String showTemperature(double temperature) {
    final tempUnit = context.watch<TempSettingsProvider>().state.tempUnit;

    if (tempUnit == TempUnit.celsius) {
      return "${temperature.toStringAsFixed(2)} ℃";
    }
    return " ${((temperature * 9 / 5) + 32).toStringAsFixed(2)} ℉";
  }

  Widget showIcon(String icon) {
    return FadeInImage.assetNetwork(
      placeholder: "assets/images/loading.gif",
      image: "http://openweathermap.org/img/wn/$icon@2x.png",
      width: 64,
      height: 64,
    );
  }

  Widget _showWeather() {
    final weatherState = context.watch<WeatherProvider>().state;

    if (weatherState.weatherStatus == WeatherStatus.initial) {
      return const Center(
          child: Text("Select a city", style: TextStyle(fontSize: 20.0)));
    }

    if (weatherState.weatherStatus == WeatherStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (weatherState.weatherStatus == WeatherStatus.error &&
        weatherState.weather.cityName == "") {
      return const Center(
          child: Text("Select a city", style: TextStyle(fontSize: 20.0)));
    }

    return ListView(
      //
      children: [
        SizedBox(height: MediaQuery.of(context).size.height / 6),

        Text(
          weatherState.weather.cityName,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 40.0,
            fontWeight: FontWeight.bold,
          ),
        ),

        //
        const SizedBox(height: 10.0),

        //
        Text(
          TimeOfDay.fromDateTime(weatherState.weather.lastUpdated)
              .format(context),
          style: const TextStyle(
            fontSize: 18.0,
          ),
          textAlign: TextAlign.center,
        ),

        //
        const SizedBox(height: 60.0),

        //
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          //
          children: [
            Text(
              showTemperature(weatherState.weather.mainTemp),
              style:
                  const TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
            ),

            //
            const SizedBox(width: 20.0),

            //
            Column(
              children: [
                Text(
                  showTemperature(weatherState.weather.mainTemp),
                  style: const TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 10.0),
                Text(
                  showTemperature(weatherState.weather.mainTemp),
                  style: const TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ],
        ),

        //
        const SizedBox(height: 30.0),

        //
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Spacer(),
            showIcon(weatherState.weather.icon),
            const SizedBox(width: 20.0),
            Text(
              weatherState.weather.weatherMain,
              style: const TextStyle(fontSize: 32.0),
            ),
            const Spacer(),
          ],
        )
      ],
    );
  }
}

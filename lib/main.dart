import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/pages/home_page.dart';
import 'package:weather_app/providers/temp_settings_provider.dart';
import 'package:weather_app/providers/theme_provider.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/repository/weather_repository.dart';
import 'package:weather_app/services/weather_api_services.dart';
import 'package:http/http.dart' as http;

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //
        ChangeNotifierProvider<WeatherProvider>(
            create: (context) => WeatherProvider(
                weatherRepository: WeatherRepository(
                    weatherApiServices:
                        WeatherApiServices(httpClient: http.Client())))),

        //
        ChangeNotifierProvider<TempSettingsProvider>(create: (context) {
          return TempSettingsProvider();
        }),

        //
        ChangeNotifierProxyProvider<WeatherProvider,ThemeProvider>(create:(context){
          return ThemeProvider();
        }, update: (BuildContext context, WeatherProvider wp, ThemeProvider? tp){
          tp!.update(wp);
          return tp;
        })
      ],

      //
      builder: (context,_) =>  MaterialApp(
        title: "Wheather app",
        debugShowCheckedModeBanner: false,
        theme: context.watch<ThemeProvider>().state.appTheme == AppTheme.dark ? ThemeData.dark() : ThemeData.light().copyWith(primaryColorDark: Colors.teal),
        home: Homepage(),
      ),
    );
  }
}

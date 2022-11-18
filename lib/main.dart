import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/pages/home_page.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: "Wheather app",
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primarySwatch: Colors.blue
      ),

      home: Homepage(),
    );
  }
}
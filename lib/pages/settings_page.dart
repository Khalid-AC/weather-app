
import 'package:flutter/material.dart';

class Settingspage extends StatefulWidget {
  Settingspage({Key? key}) : super(key: key);

  @override
  State<Settingspage> createState() => _SettingspageState();
}

class _SettingspageState extends State<Settingspage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Weather"),
        ),
        body: Center(
          child: Text("Settings"),
        ));
  }
}
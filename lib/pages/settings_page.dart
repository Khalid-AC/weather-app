import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/temp_settings_provider.dart';

class Settingspage extends StatelessWidget {
  const Settingspage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: ListTile(
          title: const Text("Temperature Unit"),
          subtitle: context.watch<TempSettingsProvider>().state.tempUnit == TempUnit.celsius ? const Text("Celsius") : const Text("Fahrenheit"),
          trailing: Switch(
              value: context.watch<TempSettingsProvider>().state.tempUnit ==
                  TempUnit.celsius,
              onChanged: (_) {
                context.read<TempSettingsProvider>().toggleTempUnit();
              }),
        ),
      ),
    );
  }
}

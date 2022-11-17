import 'package:flutter/material.dart';

class Searchpage extends StatefulWidget {
  Searchpage({Key? key}) : super(key: key);

  @override
  State<Searchpage> createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Weather"),
        ),
        body: Center(
          child: Text("Search"),
        ));
  }
}

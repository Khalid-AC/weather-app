class WeatherException implements Exception {
  String message;

  WeatherException({this.message = "Sonthing Went Wrong"});

  @override
  String toString() {
    return message;
  }
}

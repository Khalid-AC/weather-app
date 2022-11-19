class WeatherException implements Exception {
  String message;

  WeatherException({this.message = "Something Went Wrong"});

  @override
  String toString() {
    return message;
  }
}

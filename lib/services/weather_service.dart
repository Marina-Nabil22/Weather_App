import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class WeatherService {
  String baseUrl = 'https://api.openweathermap.org/data/2.5';

  String apiKey = '491329152376df95aa3b43de90209696';
  Future<WeatherModel> getWeather({required String cityName}) async {
    Uri url =
    Uri.parse('$baseUrl/weather?q=$cityName&exclude=minutely&appid=$apiKey&units=metric');
    http.Response response = await http.get(url);

    if (response.statusCode == 400) {
      var data  = jsonDecode(response.body);
      throw Exception(data['error']['message']);
    }
    Map<String, dynamic> data = jsonDecode(response.body);

    WeatherModel weather = WeatherModel.fromJson(data);

    return weather;
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:your_app_name/api/entity/current/current_weather.dart';

// bloc events
abstract class WeatherEvent {}

class FetchWeather extends WeatherEvent {
  final String city;
  FetchWeather(this.city);
}

// bloc state
abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final current_weather weatherData;
  WeatherLoaded(this.weatherData);
}

class WeatherError extends WeatherState {
  final String message;
  WeatherError(this.message);
}

// bloc
class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<FetchWeather>(_fetchWeather);
  }

  Future<void> _fetchWeather(
      FetchWeather event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    final _API_KEY = dotenv.env['API_KEY'];
    final url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=${event.city}&appid=${_API_KEY}&units=metric");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final weather = current_weather.fromJson(data);
        emit(WeatherLoaded(weather));
      } else {
        emit(WeatherError("Помилка завантаження погоди"));
      }
    } catch (e) {
      emit(WeatherError("Помилка: $e"));
    }
  }
}

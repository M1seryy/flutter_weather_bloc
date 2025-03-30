import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:your_app_name/bloc/weatherBloc.dart';

class mainScreen extends StatefulWidget {
  const mainScreen({super.key});

  @override
  State<mainScreen> createState() => _mainScreenState();
}

class _mainScreenState extends State<mainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(85, 35, 149, 1),
        ),
        body: _WeatherScreen());
  }
}

class _WeatherScreen extends StatelessWidget {
  final String city = "Mukachevo";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherBloc()..add(FetchWeather(city)),
      child: Scaffold(
        appBar: AppBar(title: Text("Погода в $city")),
        body: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is WeatherLoaded) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Місто: ${state.weatherData.name}",
                        style: TextStyle(fontSize: 22)),
                    Text("Температура: ${state.weatherData.main.temp}°C",
                        style: TextStyle(fontSize: 22)),
                    Text("Опис: ${state.weatherData.weather[0].description}",
                        style: TextStyle(fontSize: 22)),
                    Text("Хмарність: ${state.weatherData.weather[0].main}",
                        style: TextStyle(fontSize: 22)),
                  ],
                ),
              );
            } else if (state is WeatherError) {
              return Center(child: Text(state.message));
            }
            return Center(child: Text("Натисніть для завантаження погоди"));
          },
        ),
      ),
    );
  }
}

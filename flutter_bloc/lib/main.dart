import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/bloc/weather_bloc.dart';
import 'package:flutter_bloc_example/data/weather_repository.dart';

import 'data/pages/weather_search_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        builder: (_) => WeatherBloc(FakeWeatherRepository()),
        child: WeatherSearchPage(),
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:test_super_enum/weather_state.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final StreamController<WeatherState> _resultController =
      StreamController<WeatherState>();

  @override
  Widget build(BuildContext context) {
    _resultController.add(WeatherState.initial());
    return Scaffold(
      appBar: AppBar(
        title: Text("Supper Enum"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          StreamBuilder<WeatherState>(
            stream: _resultController.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return snapshot.data!.when(
                  error: (e) => Text(e.message),
                  initial: (_) => Text('State just initialized'),
                  loaded: (data) => Text(data.weather.toString()),
                  loading: (_) => CircularProgressIndicator(),
                );
              }
              return CircularProgressIndicator.adaptive();
            },
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  _resultController.add(WeatherState.loading());
                },
                child: Text('Add loading to state'),
              ),
              ElevatedButton(
                onPressed: () {
                  _resultController
                      .add(WeatherState.loaded(weather: Weather()));
                },
                child: Text('load data to state'),
              ),
              ElevatedButton(
                onPressed: () {
                  _resultController
                      .add(WeatherState.error(message: "an error occurred"));
                },
                child: Text('Add error to state'),
              )
            ],
          )
        ],
      ),
    );
  }
}

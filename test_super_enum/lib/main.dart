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
  final StreamController<WeatherState> _resultController = StreamController<WeatherState>();

  @override
  Widget build(BuildContext context) {
    _resultController.add(WeatherState.intial());
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
              return snapshot.data.when(
                error: (e) => Text(e.message),
                intial: (_) => Text('State just initialized'),
                loaded: (data) => Text(data.weather.toString()),
                loading: (_) => CircularProgressIndicator(),
              );
            },
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  _resultController.add(WeatherState.loading());
                },
                child: Text('Add loading to state'),
              ),
              RaisedButton(
                onPressed: () {
                  _resultController.add(WeatherState.loaded(weather: Weather()));
                },
                child: Text('load data to state'),
              ),
              RaisedButton(
                onPressed: () {
                  _resultController.add(WeatherState.error(message: "an error occured"));
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

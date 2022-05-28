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

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final StreamController<WeatherState> _resultController;

  @override
  void initState() {
    super.initState();
    _resultController = StreamController<WeatherState>();
  }

  @override
  void dispose() {
    _resultController.close();
  }

  @override
  Widget build(BuildContext context) {
    _resultController.add(WeatherState.initial());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Supper Enum"),
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
                  initial: () => const Text('State just initialized'),
                  loaded: (data) => Text(data.weather.toString()),
                  loading: () => const CircularProgressIndicator(),
                );
              }
              return const CircularProgressIndicator.adaptive();
            },
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  _resultController.add(WeatherState.loading());
                },
                child: const Text('Add loading to state'),
              ),
              ElevatedButton(
                onPressed: () {
                  _resultController
                      .add(WeatherState.loaded(weather: Weather()));
                },
                child: const Text('load data to state'),
              ),
              ElevatedButton(
                onPressed: () {
                  _resultController
                      .add(WeatherState.error(message: "an error occurred"));
                },
                child: const Text('Add error to state'),
              )
            ],
          )
        ],
      ),
    );
  }
}

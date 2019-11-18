import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/bloc/bloc.dart';
import 'package:flutter_bloc_example/bloc/weather_bloc.dart';
import 'package:flutter_bloc_example/data/model/weather.dart';

class WeatherDetailPage extends StatefulWidget {
  final Weather masterWeather;

  const WeatherDetailPage({Key key, this.masterWeather}) : super(key: key);

  @override
  _WeatherDetailPageState createState() => _WeatherDetailPageState();
}

class _WeatherDetailPageState extends State<WeatherDetailPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<WeatherBloc>(context)
      ..add(
        GetDetailedWeather(widget.masterWeather.cityName),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather Details"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherLoading) {
              return buildLoading();
            } else if (state is WeatherLoaded) {
              return buildColumWithData(context, state.weather);
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildColumWithData(BuildContext context, Weather weather) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          weather.cityName,
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
        ),
        Text(
          "${weather.tempreatureCelsius.toStringAsFixed(1)} C",
          style: TextStyle(fontSize: 80),
        ),
        Text(
          "${weather.tempratureFahrenheit.toStringAsFixed(1)} F",
          style: TextStyle(fontSize: 80),
        ),
      ],
    );
  }
}

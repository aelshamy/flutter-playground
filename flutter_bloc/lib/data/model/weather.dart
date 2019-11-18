import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Weather extends Equatable {
  final String cityName;
  final double tempreatureCelsius;
  final double tempratureFahrenheit;

  Weather({
    @required this.cityName,
    @required this.tempreatureCelsius,
    this.tempratureFahrenheit,
  });

  @override
  List<Object> get props => [
        cityName,
        tempreatureCelsius,
        tempreatureCelsius,
      ];
}

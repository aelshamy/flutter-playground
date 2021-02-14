import 'package:flutter/material.dart';
import 'package:flutter_inputs/ui/checkbox.dart';
import 'package:flutter_inputs/ui/datepicker.dart';
import 'package:flutter_inputs/ui/directionality.dart';
import 'package:flutter_inputs/ui/radios.dart';
import 'package:flutter_inputs/ui/slider.dart';
import 'package:flutter_inputs/ui/switches.dart';

import 'app.dart';

class Router {
  static const String homeRoute = '/';
  static const String checkboxesRoute = '/checkboxs';
  static const String radiosRoute = '/radios';
  static const String slidersRoute = '/sliders';
  static const String switchesRoute = '/switches';
  static const String datePickerRoute = '/datepicker';
  static const String directionalityRoute = '/directionality';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Router.homeRoute:
        return MaterialPageRoute(builder: (_) => InputsApp());
      case Router.checkboxesRoute:
        return MaterialPageRoute(builder: (_) => CheckboxExample());
      case Router.radiosRoute:
        return MaterialPageRoute(builder: (_) => RadiosExample());
      case Router.slidersRoute:
        return MaterialPageRoute(builder: (_) => SliderExample());
      case Router.switchesRoute:
        return MaterialPageRoute(builder: (_) => SwitchesExample());
      case Router.datePickerRoute:
        return MaterialPageRoute(builder: (_) => DatePickerExample());
      case Router.directionalityRoute:
        return MaterialPageRoute(builder: (_) => DirectionalityExample());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}

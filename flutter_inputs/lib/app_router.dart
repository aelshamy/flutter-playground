import 'package:flutter/material.dart';
import 'package:flutter_inputs/ui/checkbox.dart';
import 'package:flutter_inputs/ui/datepicker.dart';
import 'package:flutter_inputs/ui/directionality.dart';
import 'package:flutter_inputs/ui/forms/confirm_password_form.dart';
import 'package:flutter_inputs/ui/radios.dart';
import 'package:flutter_inputs/ui/slider.dart';
import 'package:flutter_inputs/ui/switches.dart';

import 'app.dart';

class AppRouter {
  static const String homeRoute = '/';
  static const String checkboxesRoute = '/checkboxs';
  static const String radiosRoute = '/radios';
  static const String slidersRoute = '/sliders';
  static const String switchesRoute = '/switches';
  static const String datePickerRoute = '/datepicker';
  static const String customFormFields = '/customFormFields';
  static const String directionalityRoute = '/directionality';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouter.homeRoute:
        return MaterialPageRoute(builder: (_) => InputsApp());
      case AppRouter.checkboxesRoute:
        return MaterialPageRoute(builder: (_) => CheckboxExample());
      case AppRouter.radiosRoute:
        return MaterialPageRoute(builder: (_) => RadiosExample());
      case AppRouter.slidersRoute:
        return MaterialPageRoute(builder: (_) => SliderExample());
      case AppRouter.switchesRoute:
        return MaterialPageRoute(builder: (_) => SwitchesExample());
      case AppRouter.datePickerRoute:
        return MaterialPageRoute(builder: (_) => DatePickerExample());
      case AppRouter.customFormFields:
        return MaterialPageRoute(builder: (_) => ConfirmPasswordForm());
      case AppRouter.directionalityRoute:
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

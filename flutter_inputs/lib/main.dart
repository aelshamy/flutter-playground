import 'package:flutter/material.dart';
import 'package:flutter_inputs/router.dart';

void main() {
  runApp(
    MaterialApp(
      onGenerateRoute: Router.generateRoute,
      initialRoute: '/',
    ),
  );
}

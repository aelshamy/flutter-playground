import 'package:flutter/material.dart';
import 'package:flutter_inputs/app_router.dart';

void main() {
  runApp(
    MaterialApp(
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: '/',
    ),
  );
}

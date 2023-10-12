import 'package:flutter/material.dart';
import 'package:flutter_undo_action/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Telegram undo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Home(),
    );
  }
}

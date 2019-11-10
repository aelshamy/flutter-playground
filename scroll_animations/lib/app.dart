import 'package:flutter/material.dart';

import 'home_page.dart';

class ScrollAnimation extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: MyHomePage(title: 'Flutter Scroll Animation'),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ui_concepts/meditation.dart';
import 'package:ui_concepts/sidebar.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            Meditation(),
            SideBar(),
          ],
        ),
      ),
    );
  }
}

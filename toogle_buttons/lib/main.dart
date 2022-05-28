import 'package:flutter/material.dart';

void main() {
  runApp(MyToggleButtonsApp());
}

class MyToggleButtonsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(title: 'Toggle Buttons Example'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<bool> _buttonsState = List.generate(4, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ToggleButtons(
          children: [
            Icon(Icons.wifi),
            Icon(Icons.bluetooth),
            Icon(Icons.highlight),
            Icon(Icons.camera),
          ],
          isSelected: _buttonsState,
          selectedColor: Colors.greenAccent,
          splashColor: Colors.teal,
          selectedBorderColor: Colors.greenAccent,
          borderWidth: 5,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          onPressed: (int index) => {
            setState(() {
              _buttonsState[index] = !_buttonsState[index];
            })
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_provider/value_notifier_demo.dart';
import 'package:provider/provider.dart';

import 'chane_notifier_demo.dart';
import 'counter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Provider Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Provider Demo"),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text("Change Notifier with custom model"),
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => ChangeNotifierProvider<Counter>(
                    builder: (context) => Counter(),
                    child: ChangeNotifierDemo(
                      title: "Change Notifier with Custom Model",
                    ),
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: Text("Change Notifier with ValueNotifier"),
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => ChangeNotifierProvider<ValueNotifier<int>>(
                    builder: (context) => ValueNotifier<int>(0),
                    child: ValueNotifierDemo(
                      title: "Change Notifier with ValueNotifier",
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

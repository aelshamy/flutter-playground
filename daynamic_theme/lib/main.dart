import 'package:daynamic_theme/settings.dart';
import 'package:daynamic_theme/theme.dart';
import 'package:daynamic_theme/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool darkModeOn = prefs.getBool('darkMode') ?? true;
  runApp(
    ChangeNotifierProvider<ThemeNotifier>(
      builder: (_) => ThemeNotifier(darkModeOn ? darkTheme : lightTheme),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      title: 'Dynamic Theme',
      theme: themeNotifier.getTheme(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dynamic Theme'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Go to Settings'),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()));
          },
        ),
      ),
    );
  }
}

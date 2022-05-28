import 'package:dynamic_theme/settings.dart';
import 'package:dynamic_theme/theme_notifier.dart';
import 'package:dynamic_theme/theme_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ThemePreferences _themePreferences = ThemePreferences();
  final isDarkModeEnabled = await _themePreferences.isDarkModeEnabled();
  runApp(
    ChangeNotifierProvider<ThemeNotifier>(
      create: (_) => ThemeNotifier()..setDarkMode(isDarkModeEnabled),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dynamic Theme',
      theme: Provider.of<ThemeNotifier>(context).theme,
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
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Settings()));
          },
        ),
      ),
    );
  }
}

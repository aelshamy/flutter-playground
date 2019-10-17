import 'package:daynamic_theme/theme.dart';
import 'package:daynamic_theme/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _darkTheme = true;
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    _darkTheme = (themeNotifier.getTheme() == darkTheme);
    return Scaffold(
      appBar: AppBar(
        title: Text('Dynamic Theme'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Use Dark Theme'),
            trailing: Switch(
              onChanged: (bool value) {
                setState(() {
                  _darkTheme = value;
                });
                onThemeChanged(value, themeNotifier);
              },
              value: _darkTheme,
            ),
          )
        ],
      ),
    );
  }

  void onThemeChanged(bool value, ThemeNotifier themeNotifier) async {
    themeNotifier.setTheme(value ? darkTheme : lightTheme);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkMode', value);
    print(prefs.getBool('darkMode'));
  }
}

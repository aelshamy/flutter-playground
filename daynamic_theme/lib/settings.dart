import 'package:daynamic_theme/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Dynamic Theme'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Use Dark Theme'),
            trailing: Switch(
              onChanged: themeNotifier.setDarkMode,
              value: themeNotifier.isDarkModeEnabled(),
            ),
          )
        ],
      ),
    );
  }
}

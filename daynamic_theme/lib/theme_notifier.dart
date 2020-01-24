import 'package:daynamic_theme/theme_preferences.dart';
import 'package:daynamic_theme/themes/dark_theme.dart';
import 'package:daynamic_theme/themes/light_theme.dart';
import 'package:flutter/material.dart';

class ThemeNotifier with ChangeNotifier {
  final ThemePreferences _themePreferences;
  ThemeData _theme;

  ThemeNotifier({ThemePreferences themePreferences, ThemeData theme})
      : _themePreferences = themePreferences ?? ThemePreferences(),
        _theme = theme ?? lightTheme;

  ThemeData get theme => _theme;

  setDarkMode(bool value) async {
    _theme = value ? darkTheme : lightTheme;
    _themePreferences.setDarkMode(value);
    notifyListeners();
  }

  isDarkModeEnabled() {
    return theme == darkTheme;
  }
}

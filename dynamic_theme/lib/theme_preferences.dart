import 'package:shared_preferences/shared_preferences.dart';

class ThemePreferences {
  late final SharedPreferences? _preferences;
  ThemePreferences({SharedPreferences? preferences})
      : _preferences = preferences;

  static const DARK_MODE_ENABLED = "darkModeEnabled";

  Future<SharedPreferences> _getInstance() async {
    return _preferences ??= await SharedPreferences.getInstance();
  }

  Future<void> setDarkMode(bool value) async {
    (await _getInstance()).setBool(DARK_MODE_ENABLED, value);
  }

  Future<bool> isDarkModeEnabled() async {
    return (await _getInstance()).getBool(DARK_MODE_ENABLED) ?? false;
  }
}

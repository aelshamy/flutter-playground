import 'package:shared_preferences/shared_preferences.dart';

class SPSettings {
  final String fontSizeKey = 'font_size';
  final String colorKey = 'color';
  static late SharedPreferences _sp;

  static late SPSettings _instance;

  SPSettings._internal();

  factory SPSettings() {
    if (_instance == null) {
      _instance = SPSettings._internal();
    }
    return _instance;
  }

  Future<void> init() async {
    _sp = await SharedPreferences.getInstance();
  }

  Future<bool> setColor(int color) {
    return _sp.setInt(colorKey, color);
  }

  int getColor() {
    return _sp.getInt(colorKey) ?? 0xff1976d2;
  }

  Future<bool> setFontSize(double size) {
    return _sp.setDouble(fontSizeKey, size);
  }

  double getFontSize() {
    return _sp.getDouble(fontSizeKey) ?? 12;
  }
}

import 'package:flutter/material.dart';
import 'package:persisting_data/data/shared_prefs.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int settingColor = 0xff1976d2;
  double fontSize = 16;

  List<int> colors = [
    0xFF455A64,
    0xFFFFC107,
    0xFF673AB7,
    0xFFF57C00,
    0xFF795548,
  ];

  late final SPSettings preferences;

  @override
  void initState() {
    super.initState();
    preferences = SPSettings();
    preferences.init().then((value) {
      setState(() {
        settingColor = preferences.getColor();
        fontSize = preferences.getFontSize();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Color(settingColor),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "Choose a font size for the app",
            style: TextStyle(fontSize: fontSize),
          ),
          DropdownButton<double>(
            value: fontSize,
            items: const [
              DropdownMenuItem(
                value: 12,
                child: Text('Small'),
              ),
              DropdownMenuItem(
                value: 16,
                child: Text('Medium'),
              ),
              DropdownMenuItem(
                value: 20,
                child: Text('Large'),
              ),
              DropdownMenuItem(
                value: 24,
                child: Text('Extra-Large'),
              ),
            ],
            onChanged: setFontSize,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: colors
                .map(
                  (color) => GestureDetector(
                    onTap: () => setColor(color),
                    child: ColorSquare(color),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  setColor(int color) {
    setState(() {
      settingColor = color;
      preferences.setColor(color);
    });
  }

  void setFontSize(double? size) {
    setState(() {
      fontSize = size!;
      preferences.setFontSize(size);
    });
    return;
  }
}

class ColorSquare extends StatelessWidget {
  final int colorCode;
  const ColorSquare(this.colorCode, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Color(colorCode),
      ),
    );
  }
}

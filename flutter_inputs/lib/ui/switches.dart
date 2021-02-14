import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inputs/ui/cupertino_switch_list_tile.dart';
import 'package:flutter_inputs/ui/switch_like_checkbox.dart';

class SwitchesExample extends StatefulWidget {
  @override
  _SwitchesExampleState createState() => _SwitchesExampleState();
}

class _SwitchesExampleState extends State<SwitchesExample> {
  bool _value1 = false;
  bool _value2 = false;
  bool _value3 = false;
  bool _value4 = false;

  void _onChanged1(bool value) => setState(() => _value1 = value);
  void _onChanged2(bool value) => setState(() => _value2 = value);
  void _onChanged3(bool value) => setState(() => _value3 = value);
  void _onChanged4(bool value) => setState(() => _value4 = value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Switches Examples'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Switch(value: _value1, onChanged: _onChanged1),
              CupertinoSwitch(value: _value3, onChanged: _onChanged3),
              SwitchListTile(
                value: _value2,
                onChanged: _onChanged2,
                title: Text(
                  'Switch List Tile',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                ),
              ),
              CupertinoSwitchListTile(
                value: _value4,
                onChanged: _onChanged4,
                title: Text(
                  'Cupertino Switch List Tile',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                ),
              ),
              CustomSwitch(
                inactiveColor: Colors.grey.shade300,
                activeColor: Colors.green,
                inactiveText: "OFF",
                activeText: "ON",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

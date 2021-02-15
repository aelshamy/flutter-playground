import 'package:flutter/material.dart';

class CheckboxExample extends StatefulWidget {
  @override
  _CheckboxExampleState createState() => _CheckboxExampleState();
}

class _CheckboxExampleState extends State<CheckboxExample> {
  bool _value1 = false;
  bool _value2 = false;

  void _value1Changed(bool value) => setState(() => _value1 = value);
  void _value2Changed(bool value) => setState(() => _value2 = value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkbox Examples'),
      ),
      body: Container(
        padding: EdgeInsets.all(25.0),
        child: Center(
          child: Column(
            children: <Widget>[
              GestureDetector(
                child: Row(
                  children: <Widget>[
                    Checkbox(value: _value1, onChanged: _value1Changed),
                    Text('Item 1'),
                  ],
                ),
                onTap: () {
                  _value1Changed(!_value1);
                },
              ),
              CheckboxListTile(
                value: _value2,
                onChanged: _value2Changed,
                title: Text('Hello World'),
                controlAffinity: ListTileControlAffinity.leading,
                subtitle: Text('Subtitle'),
                secondary: Icon(Icons.archive),
                activeColor: Colors.red,
              )
            ],
          ),
        ),
      ),
    );
  }
}

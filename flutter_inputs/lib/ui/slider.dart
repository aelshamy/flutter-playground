import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SliderExample extends StatefulWidget {
  @override
  _SliderExampleState createState() => _SliderExampleState();
}

class _SliderExampleState extends State<SliderExample> {
  double _value1 = 0.0;
  double _value2 = 0.0;
  void _setvalue1(double value) => setState(() => _value1 = value);
  void _setvalue2(double value) => setState(() => _value2 = value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Slider Example'),
      ),
      body: Container(
        padding: EdgeInsets.all(25.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Value: ${(_value1 * 100).round()}'),
              Slider(value: _value1, onChanged: _setvalue1),
              SizedBox(height: 100),
              Text('Value: ${(_value2 * 100).round()}'),
              CupertinoSlider(value: _value2, onChanged: _setvalue2),
            ],
          ),
        ),
      ),
    );
  }
}

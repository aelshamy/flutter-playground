import 'package:flutter/material.dart';

class CustomRadio<T> extends StatefulWidget {
  CustomRadio({this.value, this.onChanged});

  final T value;
  final ValueChanged<T> onChanged;

  @override
  _CustomRadioState createState() => _CustomRadioState();
}

class _CustomRadioState extends State<CustomRadio> {
  bool _checked;
  @override
  void initState() {
    super.initState();
    _checked = false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 70,
            height: 70,
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 2,
                color: Colors.blue,
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(shape: BoxShape.circle, color: _checked ? Colors.green : Colors.transparent),
                ),
                Icon(Icons.add)
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 15.0),
            child: Text(
              "My Label",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11.0),
            ),
          ),
        ],
      ),
    );
  }

  void _onTap() {
    setState(() {
      _checked = !_checked;
    });
    _checked ? this.widget.onChanged(widget.value) : this.widget.onChanged(null);
  }
}

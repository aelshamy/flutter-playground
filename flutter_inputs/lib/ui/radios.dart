import 'package:flutter/material.dart';
import 'package:flutter_inputs/ui/forms/form_fields/radio_form_field.dart';

class RadiosExample extends StatefulWidget {
  @override
  _RadiosExampleState createState() => _RadiosExampleState();
}

class _RadiosExampleState extends State<RadiosExample> {
  int? _value1 = 0;
  int? _value2 = 0;

  void _setValue1(int? value) => setState(() => _value1 = value);
  void _setValue2(int? value) => setState(() => _value2 = value);

  Widget _makeMaterialRadios() {
    List<Widget> list = [];

    for (int i = 0; i < 3; i++) {
      list.add(GestureDetector(
        child: Row(
          children: <Widget>[
            Radio(value: i, groupValue: _value1, onChanged: _setValue1),
            Text('Item ${i + 1}')
          ],
        ),
        onTap: () {
          _setValue1(i);
        },
      ));
    }

    var column = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: list,
    );
    return column;
  }

  Widget _makeRadioTiles() {
    List<Widget> list = [];

    for (int i = 0; i < 3; i++) {
      list.add(
        RadioListTile(
          value: i,
          groupValue: _value2,
          onChanged: _setValue2,
          activeColor: Colors.green,
          controlAffinity: ListTileControlAffinity.trailing,
          title: Text('Item: ${i + 1}'),
          subtitle: Text('sub title ${i + 1}'),
        ),
      );
    }

    return Column(
      children: list,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Radio Examples'),
      ),
      body: Container(
        padding: EdgeInsets.all(25.0),
        child: Center(
          child: Column(
            children: <Widget>[
              _makeMaterialRadios(),
              _makeRadioTiles(),
              // CustomRadio<String>(
              //   value: "10",
              //   onChanged: (dynamic value) {
              //     print(value);
              //   },
              // ),
              RadioFormField<String>(
                icon: Icons.ac_unit_sharp,
                value: 'tv',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

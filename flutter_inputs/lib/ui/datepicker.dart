import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerExample extends StatefulWidget {
  @override
  _DatePickerExampleState createState() => _DatePickerExampleState();
}

class _DatePickerExampleState extends State<DatePickerExample> {
  String _value = DateTime.now().toString();
  DateTime initialDate = DateTime.now();

  void _selectDate() async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );
    if (picked != null) setState(() => _value = picked.toString());
  }

  void _selectTime() async {
    TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) setState(() => _value = picked.format(context));
  }

  void _showCupertinoDatePicker(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: MediaQuery.of(context).copyWith().size.height / 4,
          child: CupertinoDatePicker(
            maximumYear: 2101,
            minimumYear: 2015,
            mode: CupertinoDatePickerMode.date,
            initialDateTime: initialDate,
            onDateTimeChanged: (DateTime value) {
              if (value.toString() != _value) {
                setState(() {
                  _value = DateFormat('MM/dd/yyyy').format(value);
                });
              }
            },
          ),
        );
      },
    );
  }

  void _showCupertinoTimePicker(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: MediaQuery.of(context).copyWith().size.height / 4,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.time,
            initialDateTime: initialDate,
            onDateTimeChanged: (DateTime value) {
              if (value.toString() != _value) {
                setState(() {
                  _value = DateFormat('MM/dd/yyyy').format(value);
                });
              }
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DatePicker Examples'),
      ),
      body: Container(
        padding: EdgeInsets.all(25.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(_value),
              RaisedButton(
                onPressed: () {
                  _selectDate();
                },
                child: Text('Show date picker'),
              ),
              RaisedButton(
                onPressed: _selectTime,
                child: Text('Show timePicker'),
              ),
              RaisedButton(
                onPressed: () {
                  _showCupertinoDatePicker(context);
                },
                child: Text('Show Cupertino date picker'),
              ),
              RaisedButton(
                onPressed: () {
                  _showCupertinoTimePicker(context);
                },
                child: Text('Show Cupertino timePicker'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

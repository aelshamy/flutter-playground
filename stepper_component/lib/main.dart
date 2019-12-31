import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stepper Component',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stepper Component'),
      ),
      body: StepperComponent(
        onValueChanged: (int value) {
          print(value);
        },
      ),
    );
  }
}

class StepperComponent extends StatefulWidget {
  final Function(int value) onValueChanged;

  StepperComponent({Key key, this.onValueChanged}) : super(key: key);

  @override
  _StepperComponentState createState() => _StepperComponentState();
}

class _StepperComponentState extends State<StepperComponent> {
  TextEditingController _controller;
  int _value = 0;

  void initState() {
    super.initState();
    _controller = TextEditingController(text: _value.toString());
  }

  setvalue() {
    setState(() {
      _value = int.parse(_controller.text);
    });
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  changeValue(int direction) {
    setState(() {
      final currentValue = int.parse(_controller.text);
      _value = currentValue + direction;
      widget.onValueChanged(_value);
    });
    _controller.text = (_value).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: _value < 1 ? null : () => changeValue(-1),
          ),
          Expanded(
            child: TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
              controller: _controller,
            ),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => changeValue(1),
          ),
        ],
      ),
    );
  }
}

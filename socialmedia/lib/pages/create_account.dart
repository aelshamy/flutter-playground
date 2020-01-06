import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  String username;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setup your profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  onSaved: (val) => username = val,
                  validator: (val) {
                    if (val.trim().length < 3 || val.isEmpty) {
                      return "Username too short";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Username",
                    labelStyle: TextStyle(fontSize: 15.0),
                    hintText: "Must be at least 3 characters",
                  ),
                ),
                SizedBox(height: 15),
                RaisedButton(
                  child: Text('Submit'),
                  color: Theme.of(context).primaryColor,
                  colorBrightness: Brightness.dark,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      Navigator.pop(context, username);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

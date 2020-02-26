import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/common/blocs/user/user_bloc.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setup your username'),
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
                  controller: _controller,
                  validator: (val) {
                    if (val.trim().length < 3 || val.isEmpty) {
                      return "Username too short";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Username",
                    labelStyle: TextStyle(fontSize: 15.0),
                    hintText: "Must be at least 3 characters",
                  ),
                ),
                const SizedBox(height: 15),
                RaisedButton(
                  color: Theme.of(context).accentColor,
                  colorBrightness: Brightness.dark,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      BlocProvider.of<UserBloc>(context).add(CreateUsername(_controller.text));
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

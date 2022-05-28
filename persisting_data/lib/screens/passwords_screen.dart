import 'package:flutter/material.dart';

import './password_detail.dart';
import '../data/sembast_db.dart';
import '../data/shared_prefs.dart';
import '../models/password.dart';

class PasswordsScreen extends StatefulWidget {
  @override
  _PasswordsScreenState createState() => _PasswordsScreenState();
}

class _PasswordsScreenState extends State<PasswordsScreen> {
  late final SembastDb db;
  int settingColor = 0xff1976d2;
  double fontSize = 16;
  late final SPSettings settings;
  @override
  void initState() {
    db = SembastDb();
    settings = SPSettings();
    settings.init().then((value) {
      setState(() {
        settingColor = settings.getColor();
        fontSize = settings.getFontSize();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Passwords List'),
        backgroundColor: Color(settingColor),
      ),
      body: FutureBuilder(
        future: getPasswords(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          List<Password> passwords = snapshot.data;
          return ListView.builder(
            itemCount: passwords.length,
            itemBuilder: (_, index) {
              return Dismissible(
                key: Key(passwords[index].id.toString()),
                onDismissed: (_) {
                  db.deletePassword(passwords[index]);
                },
                child: ListTile(
                  title: Text(
                    passwords[index].name,
                    style: TextStyle(fontSize: fontSize),
                  ),
                  trailing: Icon(Icons.edit),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return PasswordDetailDialog(passwords[index], false);
                      },
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Color(settingColor),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return PasswordDetailDialog(
                  Password(id: 1, name: '', password: ''), true);
            },
          );
        },
      ),
    );
  }

  Future<List<Password>> getPasswords() {
    return db.getPasswords();
  }
}

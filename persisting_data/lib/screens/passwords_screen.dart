import 'package:flutter/material.dart';

import './password_detail.dart';
import '../data/sembast_db.dart';
import '../data/shared_prefs.dart';
import '../models/password.dart';

class PasswordsScreen extends StatefulWidget {
  const PasswordsScreen({super.key});

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
        title: const Text('Passwords List'),
        backgroundColor: Color(settingColor),
      ),
      body: FutureBuilder(
        future: getPasswords(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
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
                    trailing: const Icon(Icons.edit),
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
          } else {
            return const CircularProgressIndicator.adaptive();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
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
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<List<Password>> getPasswords() {
    return db.getPasswords();
  }
}

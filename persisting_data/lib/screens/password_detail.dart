import 'package:flutter/material.dart';
import 'package:persisting_data/screens/passwords_screen.dart';

import '../data/sembast_db.dart';
import '../models/password.dart';

class PasswordDetailDialog extends StatefulWidget {
  final Password password;
  final bool isNew;

  const PasswordDetailDialog(this.password, this.isNew, {super.key});

  @override
  _PasswordDetailDialogState createState() => _PasswordDetailDialogState();
}

class _PasswordDetailDialogState extends State<PasswordDetailDialog> {
  final TextEditingController txtName = TextEditingController();
  final TextEditingController txtPassword = TextEditingController();
  bool hidePassword = true;
  @override
  Widget build(BuildContext context) {
    String title = (widget.isNew) ? 'Insert new Password' : 'Edit Password';
    txtName.text = widget.password.name;
    txtPassword.text = widget.password.password;
    return AlertDialog(
      title: Text(title),
      content: Column(
        children: [
          TextField(
            controller: txtName,
            decoration: const InputDecoration(
              hintText: 'Description',
            ),
          ),
          TextField(
            controller: txtPassword,
            obscureText: hidePassword,
            decoration: InputDecoration(
              hintText: 'Password',
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    hidePassword = !hidePassword;
                  });
                },
                icon: hidePassword
                    ? const Icon(Icons.visibility)
                    : const Icon(Icons.visibility_off),
              ),
            ),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          child: const Text('Save'),
          onPressed: () {
            final pass = widget.password.copyWith(
              name: txtName.text,
              password: txtPassword.text,
            );

            SembastDb db = SembastDb();
            (widget.isNew) ? db.addPassword(pass) : db.updatePassword(pass);

            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PasswordsScreen(),
              ),
            );
          },
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}

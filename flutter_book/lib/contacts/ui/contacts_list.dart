import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_book/config.dart';
import 'package:flutter_book/contacts/bloc/contacts_bloc.dart';
import 'package:flutter_book/contacts/contact.dart';
import 'package:flutter_book/contacts/ui/contact_item.dart';
import 'package:path/path.dart';

class ContactsList extends StatelessWidget {
  const ContactsList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ContactsBloc, ContactsState>(
        builder: (context, state) {
          if (state is ContactsLoaded) {
            return ListView.separated(
              itemCount: state.contacts.length,
              itemBuilder: (BuildContext inBuildContext, int inIndex) {
                Contact contact = state.contacts[inIndex];

                File avatarFile = File(join(AppConfig.docsDir.path, contact.id.toString()));
                bool avatarFileExists = avatarFile.existsSync();

                return Dismissible(
                  key: ValueKey(contact.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    padding: EdgeInsets.only(right: 10),
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.delete),
                  ),
                  confirmDismiss: (direction) => _confirmDismiss(context, contact.name),
                  onDismissed: (direction) => _deleteContact(context, contact),
                  child: ListTile(
                    leading: CircleAvatar(
                        backgroundColor: Colors.indigoAccent,
                        foregroundColor: Colors.white,
                        backgroundImage: avatarFileExists ? FileImage(avatarFile) : null,
                        child: avatarFileExists
                            ? null
                            : Text(contact.name.substring(0, 1).toUpperCase())),
                    title: Text("${contact.name}"),
                    subtitle: contact.phone == null ? null : Text("${contact.phone}"),
                    onTap: () async {
                      File avatarFile = File(join(AppConfig.docsDir.path, "avatar"));
                      if (avatarFile.existsSync()) {
                        avatarFile.deleteSync();
                      }
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: BlocProvider.of<ContactsBloc>(context),
                            child: ContactItem(
                              contact: contact,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  Divider(), /* End itemBuilder. */
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: BlocProvider.of<ContactsBloc>(context),
                child: ContactItem(contact: Contact()),
              ),
            ),
          );
        },
      ),
    );
  }

  void _deleteContact(BuildContext context, Contact contact) async {
    BlocProvider.of<ContactsBloc>(context).add(DeleteContact(contactId: contact.id));
    Scaffold.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
        content: Text("Task deleted"),
      ),
    );
  }

  Future<bool> _confirmDismiss(BuildContext context, String contactName) async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext inAlertContext) {
        return AlertDialog(
          title: Text("Delete Task"),
          content: RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.black),
              children: <TextSpan>[
                TextSpan(text: 'Are you sure you want to delete "'),
                TextSpan(text: "$contactName", style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: '"?'),
              ],
            ),
          ),
          actions: [
            FlatButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(inAlertContext).pop(false);
              },
            ),
            FlatButton(
              child: Text("Delete"),
              onPressed: () async {
                Navigator.of(inAlertContext).pop(true);
              },
            )
          ],
        );
      },
    );
  }
}

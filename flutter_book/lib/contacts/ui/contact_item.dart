import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_book/config.dart';
import 'package:flutter_book/contacts/bloc/contacts_bloc.dart';
import 'package:flutter_book/contacts/contact.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

class ContactItem extends StatefulWidget {
  final Contact contact;
  const ContactItem({Key? key, required this.contact}) : super(key: key);

  @override
  ContactItemState createState() => ContactItemState();
}

class ContactItemState extends State<ContactItem> {
  late final TextEditingController _nameEditingController;
  late final TextEditingController _phoneEditingController;
  late final TextEditingController _emailEditingController;
  late final TextEditingController _birthdayEditingController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _nameEditingController = TextEditingController(text: widget.contact.name);
    _phoneEditingController = TextEditingController(text: widget.contact.phone);
    _emailEditingController = TextEditingController(text: widget.contact.email);
    _birthdayEditingController =
        TextEditingController(text: widget.contact.birthday);
  }

  @override
  Widget build(BuildContext context) {
    File avatarFile = File(join(AppConfig.docsDir.path, "avatar"));
    if (avatarFile.existsSync() == false) {
      avatarFile =
          File(join(AppConfig.docsDir.path, widget.contact.id.toString()));
    }
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            const SizedBox(height: 50),
            Center(
              child: GestureDetector(
                onTap: () => _selectAvatar(context),
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                    image: avatarFile.existsSync()
                        ? DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(avatarFile),
                          )
                        : null,
                  ),
                  child: !avatarFile.existsSync()
                      ? const Icon(
                          Icons.image,
                          size: 60,
                        )
                      : null,
                ),
              ),
            ),
            const SizedBox(height: 50),
            // Center(
            //   child: ListTile(
            //     title:
            //         : Text("No avatar image for this contact"),
            //     trailing: IconButton(
            //       icon: Icon(Icons.edit),
            //       color: Colors.blue,
            //       onPressed: () => _selectAvatar(context),
            //     ),
            //   ),
            // ),
            ListTile(
              leading: const Icon(Icons.person),
              title: TextFormField(
                decoration: const InputDecoration(hintText: "Name"),
                controller: _nameEditingController,
                validator: (String? inValue) {
                  if (inValue?.isEmpty == true) {
                    return "Please enter a name";
                  }
                  return null;
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.phone),
              title: TextFormField(
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(hintText: "Phone"),
                controller: _phoneEditingController,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.email),
              title: TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(hintText: "Email"),
                controller: _emailEditingController,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.today),
              title: TextFormField(
                decoration: InputDecoration(
                  hintText: "Birthday",
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.edit),
                    color: Colors.blue,
                    onPressed: () async {
                      String selectedDate = await _selectDate(context);
                      _birthdayEditingController.text = selectedDate;
                    },
                  ),
                ),
                controller: _birthdayEditingController,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(
              label: const Text("Cancel"),
              icon: const Icon(
                Icons.cancel,
                color: Colors.red,
              ),
              onPressed: () {
                File avatarFile = File(join(AppConfig.docsDir.path, "avatar"));
                if (avatarFile.existsSync()) {
                  avatarFile.deleteSync();
                }
                Navigator.of(context).pop();
              },
            ),
            Builder(
              builder: (context) => TextButton.icon(
                label: const Text("Save"),
                icon: const Icon(
                  Icons.save,
                  color: Colors.green,
                ),
                onPressed: () {
                  _save(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _selectAvatar(BuildContext inContext) {
    return showDialog(
      context: inContext,
      builder: (BuildContext inDialogContext) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                GestureDetector(
                    child: const Text("Take a picture"),
                    onTap: () async {
                      var cameraImage = await picker.pickImage(
                        source: ImageSource.camera,
                      );
                      if (cameraImage != null) {
                        File(cameraImage.path)
                            .copySync(join(AppConfig.docsDir.path, "avatar"));
                      }
                      setState(() {});
                      Navigator.of(inContext).pop();
                    }),
                const Padding(padding: EdgeInsets.all(10)),
                GestureDetector(
                    child: const Text("Select From Gallery"),
                    onTap: () async {
                      var galleryImage =
                          await picker.pickImage(source: ImageSource.gallery);
                      if (galleryImage != null) {
                        File(galleryImage.path)
                            .copySync(join(AppConfig.docsDir.path, "avatar"));
                      }
                      setState(() {});
                      Navigator.of(inDialogContext).pop();
                    })
              ],
            ),
          ),
        );
      },
    );
  }

  Future<String> _selectDate(BuildContext context) async {
    DateTime initialDate = DateTime.now();
    initialDate = DateFormat.yMMMMd("en_US").parse(widget.contact.birthday);
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    return DateFormat.yMMMMd("en_US").format(picked!.toLocal());
  }

  void _save(BuildContext context) async {
    if (_formKey.currentState?.validate() == true) {
      if (widget.contact.id > 0) {
        BlocProvider.of<ContactsBloc>(context).add(
          AddContact(
            contact: Contact(
              name: _nameEditingController.text,
              phone: _phoneEditingController.text,
              email: _emailEditingController.text,
              birthday: _birthdayEditingController.text,
            ),
          ),
        );
      } else {
        BlocProvider.of<ContactsBloc>(context).add(
          UpdateContact(
            contact: widget.contact.copyWith(
              name: _nameEditingController.text,
              phone: _phoneEditingController.text,
              email: _emailEditingController.text,
              birthday: _birthdayEditingController.text,
            ),
          ),
        );
      }

      File avatarFile = File(join(AppConfig.docsDir.path, "avatar"));
      if (avatarFile.existsSync()) {
        avatarFile.renameSync(
            join(AppConfig.docsDir.path, widget.contact.id.toString()));
      }

      await ScaffoldMessenger.of(context)
          .showSnackBar(
            const SnackBar(
              backgroundColor: Colors.green,
              duration: Duration(seconds: 1),
              content: Text("Appointment saved"),
            ),
          )
          .closed;
    }
  }

  @override
  void dispose() {
    _nameEditingController.dispose();
    _phoneEditingController.dispose();
    _emailEditingController.dispose();
    _birthdayEditingController.dispose();
    super.dispose();
  }
}

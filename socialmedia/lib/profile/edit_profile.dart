import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/auth/bloc/bloc.dart';
import 'package:socialmedia/common/model/user.dart';
import 'package:socialmedia/login/bloc/bloc.dart';
import 'package:socialmedia/login/bloc/login_bloc.dart';

class EditProfile extends StatefulWidget {
  final User user;

  EditProfile({Key key, this.user}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController _displayNameController;
  TextEditingController _bioController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _displayNameController = TextEditingController(text: widget.user.displayName);
    _bioController = TextEditingController(text: widget.user.bio);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Edit Profile',
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.done,
              size: 30,
              color: Colors.green,
            ),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 20),
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: CachedNetworkImageProvider(widget.user?.photoUrl),
              ),
            ),
            SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _displayNameController,
                    decoration: InputDecoration(hintText: "Update Display Name"),
                    validator: (value) {
                      if (value.trim().length < 3 || value.isEmpty) {
                        return "Display name is too short";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    controller: _bioController,
                    decoration: InputDecoration(hintText: "Update Bio"),
                    validator: (value) {
                      if (value.trim().length > 100) {
                        return "Bio is too long";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 12),
                  RaisedButton(
                    child: Text(
                      'Update Profile',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    color: Colors.blue,
                    onPressed: updateProfileData,
                  ),
                  SizedBox(height: 12),
                  FlatButton.icon(
                    icon: Icon(
                      Icons.cancel,
                      color: Colors.red,
                    ),
                    label: Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () => BlocProvider.of<LoginBloc>(context).add(Logout()),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updateProfileData() {
    if (_formKey.currentState.validate()) {
      BlocProvider.of<AuthBloc>(context)
          .add(UpdateUser(userId: widget.user.id, displayName: _displayNameController.text, bio: _bioController.text));
    }
  }
}

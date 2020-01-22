import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/auth/bloc/bloc.dart';
import 'package:socialmedia/common/model/user.dart';
import 'package:socialmedia/common/widgets/header.dart';
import 'package:socialmedia/login/bloc/bloc.dart';

class EditProfile extends StatefulWidget {
  final User user;

  const EditProfile({Key key, this.user}) : super(key: key);

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
      backgroundColor: Colors.white,
      appBar: Header(
        title: 'Edit Profile',
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
              BlocProvider.of<LoginBloc>(context).add(Logout());
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 20),
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: CachedNetworkImageProvider(widget.user?.photoUrl),
              ),
            ),
            const SizedBox(height: 40),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _displayNameController,
                    style: TextStyle(color: Colors.grey.shade600),
                    cursorColor: Colors.grey.shade600,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: Colors.grey.shade200,
                      hintText: 'Update display name',
                      hintStyle: TextStyle(color: Colors.grey.shade400),
                      filled: true,
                    ),
                    validator: (value) {
                      if (value.trim().length < 3 || value.isEmpty) {
                        return "Display name is too short";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _bioController,
                    style: TextStyle(color: Colors.grey.shade600),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: Colors.grey.shade200,
                      hintText: 'Update user bio',
                      hintStyle: TextStyle(color: Colors.grey.shade400),
                      filled: true,
                    ),
                    validator: (value) {
                      if (value.trim().length > 100) {
                        return "Bio is too long";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  RaisedButton(
                    color: Theme.of(context).accentColor,
                    onPressed: updateProfileData,
                    child: const Text(
                      'Update Profile',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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

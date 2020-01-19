import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia/common/model/user.dart';
import 'package:socialmedia/common/widgets/progress.dart';
import 'package:socialmedia/login/login.dart';

class EditProfile extends StatefulWidget {
  final String currentUserId;
  const EditProfile({Key key, this.currentUserId}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool isLoading = false;
  User user;
  TextEditingController displayNameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    getUser();
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
      body: isLoading
          ? CircularProgress()
          : Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: <Widget>[
                  SizedBox(height: 20),
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: CachedNetworkImageProvider(user.photoUrl),
                    ),
                  ),
                  SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: displayNameController,
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
                          controller: bioController,
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
                          onPressed: logout,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  void getUser() async {
    // setState(() {
    //   isLoading = true;
    // });
    // DocumentSnapshot doc = await usersRef.document(widget.currentUserId).get();
    // user = User.fromDocument(doc);
    // displayNameController.text = user.displayName;
    // bioController.text = user.bio;
    // setState(() {
    //   isLoading = false;
    // });
  }

  void updateProfileData() {
    // if (_formKey.currentState.validate()) {
    //   usersRef.document(widget.currentUserId).updateData({
    //     "displayName": displayNameController.text,
    //     "bio": bioController.text,
    //   });
    // }
  }

  Future<void> logout() async {
    // await googleSignIn.signOut();
    await Navigator.pushReplacement<dynamic, dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => Login(),
      ),
    );
  }
}

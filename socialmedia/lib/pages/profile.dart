import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia/model/user.dart';
import 'package:socialmedia/widgets/header.dart';
import 'package:socialmedia/widgets/progress.dart';

import 'edit_profile.dart';
import 'home.dart';

class Profile extends StatefulWidget {
  final String profileId;
  const Profile({Key key, this.profileId}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final String currentUserId = currentUser?.id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(title: "Profile"),
      body: ListView(
        children: <Widget>[
          buildProfileHeader(),
        ],
      ),
    );
  }

  buildProfileHeader() {
    return StreamBuilder(
      stream: usersRef.document(widget.profileId).snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return CircularProgress();
        }
        User user = User.fromDocument(snapshot.data);
        return Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.grey,
                        backgroundImage: CachedNetworkImageProvider(user.photoUrl),
                      ),
                      Text(
                        user.username,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        user.displayName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      buildCountColumn("posts", 0),
                                      buildCountColumn("followers", 0),
                                      buildCountColumn("following", 0),
                                    ],
                                  ),
                                  SizedBox(height: 12),
                                  buildProfileButton(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 12),
              Text(
                user.bio,
                style: TextStyle(height: 1.5),
              ),
            ],
          ),
        );
      },
    );
  }

  buildCountColumn(String label, int count) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          count.toString(),
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  buildProfileButton() {
    bool isProfileOwner = currentUserId == widget.profileId;
    if (isProfileOwner) {
      return buildButton(text: "Edit Profile", function: editProfile);
    }
    return Text('Profile button');
  }

  buildButton({String text, Function function}) {
    return Container(
      padding: EdgeInsets.only(top: 2),
      child: FlatButton(
        onPressed: function,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue,
            border: Border.all(color: Colors.blue),
            borderRadius: BorderRadius.circular(5),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          width: 250,
          height: 27,
        ),
      ),
    );
  }

  editProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => EditProfile(currentUserId: currentUserId),
      ),
    );
  }
}

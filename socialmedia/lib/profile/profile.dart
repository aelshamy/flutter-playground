import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:socialmedia/common/widgets/header.dart';
import 'package:socialmedia/common/widgets/progress.dart';
import 'package:socialmedia/model/post.dart';

import 'edit_profile.dart';
import 'widgets/post_item.dart';
import 'widgets/post_tile.dart';

class Profile extends StatefulWidget {
  final String profileId;
  const Profile({Key key, this.profileId}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  // final String currentUserId = currentUser?.id;
  final String currentUserId = '1';
  bool isLoading = false;
  int postCount = 0;
  List<Post> posts = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(title: "Profile"),
      body: DefaultTabController(
        length: 2,
        child: Column(
          // physics: ClampingScrollPhysics(),
          children: <Widget>[
            buildProfileHeader(),
            Divider(height: 0.0),
            TabBar(
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.transparent,
              labelPadding: EdgeInsets.all(5),
              tabs: <Widget>[
                Icon(Icons.grid_on),
                Icon(Icons.list),
              ],
            ),
            Divider(height: 0.0),
            Expanded(
              child: StreamBuilder(
                stream: getProfilePost(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgress();
                  }

                  List<Post> posts =
                      snapshot.data.documents.map((doc) => Post.fromDocument(doc)).toList();

                  postCount = snapshot.data.documents.length;

                  if (posts.isEmpty) {
                    return buildSplashScreen(context);
                  }
                  return TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      buildProfileGridPost(posts),
                      buildProfileColumnPost(posts),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildProfileHeader() {
    // return StreamBuilder(
    //   stream: usersRef.document(widget.profileId).snapshots(),
    //   builder: (BuildContext context, AsyncSnapshot snapshot) {
    //     if (!snapshot.hasData) {
    //       return CircularProgress();
    //     }
    //     User user = User.fromDocument(snapshot.data);
    //     return Padding(
    //       padding: EdgeInsets.all(16),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: <Widget>[
    //           Row(
    //             children: <Widget>[
    //               Column(
    //                 children: <Widget>[
    //                   CircleAvatar(
    //                     radius: 40,
    //                     backgroundColor: Colors.grey,
    //                     backgroundImage: CachedNetworkImageProvider(user.photoUrl),
    //                   ),
    //                   Text(
    //                     user.username,
    //                     style: TextStyle(
    //                       fontWeight: FontWeight.bold,
    //                       fontSize: 16,
    //                     ),
    //                   ),
    //                   SizedBox(height: 4),
    //                   Text(
    //                     user.displayName,
    //                     style: TextStyle(
    //                       fontWeight: FontWeight.bold,
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //               Expanded(
    //                 child: Column(
    //                   children: <Widget>[
    //                     Row(
    //                       children: <Widget>[
    //                         Expanded(
    //                           child: Column(
    //                             children: <Widget>[
    //                               Row(
    //                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                                 children: <Widget>[
    //                                   buildCountColumn("posts", postCount),
    //                                   buildCountColumn("followers", 0),
    //                                   buildCountColumn("following", 0),
    //                                 ],
    //                               ),
    //                               SizedBox(height: 12),
    //                               buildProfileButton(),
    //                             ],
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ],
    //                 ),
    //               )
    //             ],
    //           ),
    //           SizedBox(height: 12),
    //           Text(
    //             user.bio,
    //             style: TextStyle(height: 1.5),
    //           ),
    //         ],
    //       ),
    //     );
    //   },
    // );
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

  buildProfileColumnPost(List<Post> posts) {
    return ListView(
      children: posts.map((post) => PostItem(post: post)).toList(),
    );
  }

  buildProfileGridPost(List<Post> posts) {
    List<GridTile> gridTiles = posts
        .map((post) => GridTile(
              child: PostTile(
                post: post,
              ),
            ))
        .toList();

    return GridView.count(
      crossAxisCount: 3,
      childAspectRatio: 1.0,
      mainAxisSpacing: 1.5,
      crossAxisSpacing: 1.5,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: gridTiles,
    );
  }

  Stream<QuerySnapshot> getProfilePost() {
    // return postRef
    //     .document(widget.profileId)
    //     .collection("userPosts")
    //     .orderBy("timestamp", descending: true)
    //     .snapshots();
  }

  buildSplashScreen(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SvgPicture.asset('assets/images/no_content.svg', height: 200),
        SizedBox(height: 10),
        Text(
          'No Posts',
          style: TextStyle(
            color: Colors.redAccent,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}

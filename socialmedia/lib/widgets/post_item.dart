import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia/model/post.dart';
import 'package:socialmedia/model/user.dart';
import 'package:socialmedia/pages/home.dart';
import 'package:socialmedia/widgets/progress.dart';

class PostItem extends StatelessWidget {
  final Post post;
  PostItem({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        StreamBuilder(
          stream: usersRef.document(post.owner).snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return CircularProgress();
            }
            User user = User.fromDocument(snapshot.data);
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(user.photoUrl),
                backgroundColor: Colors.grey,
              ),
              title: GestureDetector(
                onTap: () => print("User Clicked "),
                child: Text(
                  user.username,
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              subtitle: Text(post.location),
              trailing: IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () => print("Deleting Post"),
              ),
            );
          },
        ),
        GestureDetector(
          onDoubleTap: () => print('Liking Post'),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: post.mediaUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => Padding(
                  padding: EdgeInsets.all(20),
                  child: CircularProgress(),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 10),
          child: Row(
            children: <Widget>[
              SizedBox(height: 40),
              GestureDetector(
                onTap: () => print('Liking Post'),
                child: Icon(
                  Icons.favorite_border,
                  size: 28,
                  color: Colors.pink,
                ),
              ),
              SizedBox(width: 20),
              GestureDetector(
                onTap: () => print('Showing Comments'),
                child: Icon(
                  Icons.chat,
                  size: 28,
                  color: Colors.blue.shade900,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Text(
                "${post.getLikeCount()} Likes",
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Text(
                "${post.username} ",
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Text(post.description),
            ),
          ],
        ),
      ],
    );
  }
}

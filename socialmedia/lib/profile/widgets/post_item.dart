import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia/comments/comments.dart';
import 'package:socialmedia/common/model/post.dart';
import 'package:socialmedia/common/widgets/progress.dart';

class PostItem extends StatelessWidget {
  final Post post;
  PostItem({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // StreamBuilder(
        //   stream: usersRef.document(post.owner).snapshots(),
        //   builder: (BuildContext context, AsyncSnapshot snapshot) {
        //     if (!snapshot.hasData) {
        //       return CircularProgress();
        //     }
        //     User user = User.fromDocument(snapshot.data);
        //     return ListTile(
        //       leading: CircleAvatar(
        //         backgroundImage: CachedNetworkImageProvider(user.photoUrl),
        //         backgroundColor: Colors.grey,
        //       ),
        //       title: GestureDetector(
        //         onTap: () => print("User Clicked "),
        //         child: Text(
        //           user.username,
        //           style: TextStyle(
        //             color: Colors.blue,
        //             fontWeight: FontWeight.bold,
        //           ),
        //         ),
        //       ),
        //       subtitle: Text(post.location),
        //       trailing: IconButton(
        //         icon: Icon(Icons.more_vert),
        //         onPressed: () => print("Deleting Post"),
        //       ),
        //     );
        //   },
        // ),
        GestureDetector(
          onDoubleTap: handleLikePost,
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
              post.isLikedByCurrentUser()
                  ? TweenAnimationBuilder(
                      duration: Duration(milliseconds: 300),
                      tween: Tween(begin: 0.5, end: 1.5),
                      builder: (BuildContext context, double value, Widget child) => Transform.scale(
                        //TODO: fix animation
                        scale: value,
                        child: Icon(
                          Icons.favorite,
                          size: 80,
                          color: Colors.red,
                        ),
                      ),
                    )
                  // Animator(
                  //     resetAnimationOnRebuild: true,
                  //     duration: Duration(milliseconds: 300),
                  //     tween: Tween(begin: 0.5, end: 1.5),
                  //     curve: Curves.elasticOut,
                  //     cycles: 0,
                  //     builder: (anim) => Transform.scale(
                  //       scale: anim.value,
                  //       child: Icon(
                  //         Icons.favorite,
                  //         size: 80,
                  //         color: Colors.red,
                  //       ),
                  //     ),
                  //   )
                  : SizedBox(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 10),
          child: Row(
            children: <Widget>[
              SizedBox(height: 40),
              GestureDetector(
                onTap: handleLikePost,
                child: Icon(
                  post.isLikedByCurrentUser() ? Icons.favorite : Icons.favorite_border,
                  size: 28,
                  color: Colors.pink,
                ),
              ),
              SizedBox(width: 20),
              GestureDetector(
                onTap: () => showComments(context),
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

  void handleLikePost() {
    post.likePost();
  }

  void showComments(BuildContext context) {
    Navigator.of(context).push<dynamic>(MaterialPageRoute<dynamic>(builder: (BuildContext context) => Comments(post: post)));
  }
}

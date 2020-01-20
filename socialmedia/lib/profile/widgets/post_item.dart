import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/comments/comments.dart';
import 'package:socialmedia/common/model/post.dart';
import 'package:socialmedia/common/model/user.dart';
import 'package:socialmedia/common/widgets/progress.dart';
import 'package:socialmedia/profile/bloc/bloc.dart';
import 'package:socialmedia/profile/bloc/profile_bloc.dart';

class PostItem extends StatelessWidget {
  final Post post;
  final User user;
  const PostItem({Key key, this.post, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
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
        ),
        GestureDetector(
          onDoubleTap: () {
            likePost(context);
          },
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: post.mediaUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Padding(
                  padding: EdgeInsets.all(20),
                  child: CircularProgress(),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              if (post.likes[user?.id] == true)
                {
                  TweenAnimationBuilder(
                    duration: const Duration(milliseconds: 300),
                    tween: Tween(begin: 0.5, end: 1.5),
                    builder: (BuildContext context, double value, Widget child) => Transform.scale(
                      //TODO: fix animation
                      scale: value,
                      child: const Icon(
                        Icons.favorite,
                        size: 80,
                        color: Colors.red,
                      ),
                    ),
                  ),
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
                }
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 10),
          child: Row(
            children: <Widget>[
              const SizedBox(height: 40),
              GestureDetector(
                onTap: () {
                  likePost(context);
                },
                child: Icon(
                  post.likes[user?.id] == true ? Icons.favorite : Icons.favorite_border,
                  size: 28,
                  color: Colors.pink,
                ),
              ),
              const SizedBox(width: 20),
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
        const SizedBox(height: 10),
        Row(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: Text(
                "${getLikeCount()} Likes",
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(left: 20),
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

  void likePost(BuildContext context) {
    BlocProvider.of<ProfileBloc>(context).add(LikePost(post: post, user: user));
  }

  int getLikeCount() {
    if (post.likes == null) return 0;
    return post.likes.values.takeWhile((dynamic item) => item == true).length as int;
  }

  void showComments(BuildContext context) {
    Navigator.of(context).push<dynamic>(MaterialPageRoute<dynamic>(builder: (BuildContext context) => Comments(post: post)));
  }
}

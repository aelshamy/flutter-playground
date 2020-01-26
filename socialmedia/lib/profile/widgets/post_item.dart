import 'dart:async';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/comments/bloc/bloc.dart';
import 'package:socialmedia/comments/comments.dart';
import 'package:socialmedia/common/model/post.dart';
import 'package:socialmedia/common/model/user.dart';
import 'package:socialmedia/common/widgets/progress.dart';
import 'package:socialmedia/profile/bloc/bloc.dart';
import 'package:socialmedia/profile/bloc/profile_bloc.dart';

class PostItem extends StatefulWidget {
  final Post post;
  final User user;
  const PostItem({Key key, this.post, this.user}) : super(key: key);

  @override
  _PostItemState createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  bool _showLikeAnimation = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListTile(
          leading: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(widget.user.photoUrl),
            backgroundColor: Colors.grey,
          ),
          title: GestureDetector(
            onTap: () => log("User Clicked "),
            child: Text(
              widget.user.username,
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          subtitle: Text(widget.post.location),
          trailing: IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () => log("Deleting Post"),
          ),
        ),
        GestureDetector(
          onDoubleTap: () {
            if (widget.post.likes[widget.user.id] != true) {
              setState(() {
                _showLikeAnimation = true;
              });

              Timer(const Duration(milliseconds: 800), () {
                setState(() {
                  _showLikeAnimation = false;
                });
              });
            }
            likePost(context);
          },
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 16 / 9,
                child: CachedNetworkImage(
                  imageUrl: widget.post.mediaUrl,
                  // height: 250,
                  fit: BoxFit.fitWidth,
                  placeholder: (context, url) => const Padding(
                    padding: EdgeInsets.all(20),
                    child: CircularProgress(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              if (_showLikeAnimation)
                TweenAnimationBuilder(
                  duration: const Duration(milliseconds: 300),
                  tween: Tween(begin: 0.5, end: 1.5),
                  builder: (BuildContext context, double value, Widget child) => Transform.scale(
                    scale: value,
                    child: const Icon(
                      Icons.favorite,
                      size: 100,
                      color: Colors.red,
                    ),
                  ),
                ),
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
                  widget.post.likes[widget.user?.id] == true
                      ? Icons.favorite
                      : Icons.favorite_border,
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
        Container(
          margin: const EdgeInsets.only(left: 20),
          child: Text(
            "${getLikeCount()} Likes",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10),
        Text(widget.post.description),
      ],
    );
  }

  void likePost(BuildContext context) {
    BlocProvider.of<ProfileBloc>(context).add(LikePost(post: widget.post, user: widget.user));
  }

  int getLikeCount() {
    if (widget.post.likes == null) return 0;
    return widget.post.likes.values.takeWhile((item) => item == true).length as int;
  }

  void showComments(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => BlocProvider<CommentsBloc>(
          create: (context) => CommentsBloc()..add(LoadComments(postId: widget.post.postId)),
          child: Comments(post: widget.post),
        ),
      ),
    );
  }
}

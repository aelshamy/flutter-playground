import 'package:flutter/material.dart';
import 'package:socialmedia/common/model/post.dart';
import 'package:socialmedia/common/model/user.dart';
import 'package:socialmedia/common/widgets/header.dart';
import 'package:socialmedia/profile/widgets/post_item.dart';

class PostPage extends StatelessWidget {
  final User user;
  final Post post;
  const PostPage({Key key, this.user, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(
        title: "Post",
      ),
      body: PostItem(
        user: user,
        post: post,
      ),
    );
  }
}

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia/common/model/post.dart';
import 'package:socialmedia/common/widgets/progress.dart';

class PostTile extends StatelessWidget {
  final Post post;

  const PostTile({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => log('showing posts'),
      child: CachedNetworkImage(
        imageUrl: post.mediaUrl,
        fit: BoxFit.cover,
        placeholder: (context, url) => const Padding(
          padding: EdgeInsets.all(20),
          child: CircularProgress(),
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }
}

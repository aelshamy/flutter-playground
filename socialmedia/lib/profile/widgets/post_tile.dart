import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia/common/widgets/progress.dart';
import 'package:socialmedia/model/post.dart';

class PostTile extends StatelessWidget {
  final Post post;

  const PostTile({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print('showing posts'),
      child: CachedNetworkImage(
        imageUrl: post.mediaUrl,
        fit: BoxFit.cover,
        placeholder: (context, url) => Padding(
          padding: EdgeInsets.all(20),
          child: CircularProgress(),
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }
}

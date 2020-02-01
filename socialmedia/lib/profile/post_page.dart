import 'package:flutter/material.dart';
import 'package:socialmedia/common/widgets/header.dart';

class PostPage extends StatelessWidget {
  const PostPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(),
    );
  }
}

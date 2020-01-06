import 'package:flutter/material.dart';
import 'package:socialmedia/widgets/header.dart';

class ActivityFeed extends StatelessWidget {
  const ActivityFeed({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: Center(child: Text('Feed')),
    );
  }
}

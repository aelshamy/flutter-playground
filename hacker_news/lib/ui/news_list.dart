import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news/blocs/stories/stories_bloc.dart';

class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Top News')),
      body: BlocBuilder<StoriesBloc, StoriesState>(
        builder: (BuildContext context, StoriesState state) {
          return Center(
            child: Text('Show some news here!'),
          );
        },
      ),
    );
  }
}

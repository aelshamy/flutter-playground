import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news/blocs/stories/stories_bloc.dart';
import 'package:hacker_news/ui/news_list.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider<StoriesBloc>(
        create: (context) => StoriesBloc(),
        child: NewsList(),
      ),
    );
  }
}

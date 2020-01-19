import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/feed/activity_feed.dart';
import 'package:socialmedia/profile/profile.dart';
import 'package:socialmedia/search/bloc/bloc.dart';
import 'package:socialmedia/search/search.dart';
import 'package:socialmedia/timeline/timeline.dart';
import 'package:socialmedia/upload/upload.dart';

class Home extends StatelessWidget {
  final List<Widget> _pages;
  Home({Key key})
      : _pages = [
          Timeline(),
          ActivityFeed(),
          Upload(),
          Search(),
          Profile(),
        ],
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        activeColor: Theme.of(context).primaryColor,
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.whatshot),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_active),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.photo_camera,
              size: 50,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return _pages[0];
          case 1:
            return _pages[1];
          case 2:
            return _pages[2];
          case 3:
            return BlocProvider<SearchBloc>(
              create: (context) => SearchBloc(),
              child: _pages[3],
            );
          case 4:
            return _pages[4];
        }
      },
    );
  }
}

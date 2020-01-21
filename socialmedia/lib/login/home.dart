import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/auth/bloc/bloc.dart';
import 'package:socialmedia/comments/bloc/bloc.dart';
import 'package:socialmedia/common/model/user.dart';
import 'package:socialmedia/feed/activity_feed.dart';
import 'package:socialmedia/profile/bloc/bloc.dart';
import 'package:socialmedia/profile/bloc/profile_bloc.dart';
import 'package:socialmedia/profile/profile.dart';
import 'package:socialmedia/repo/firestore_repo.dart';
import 'package:socialmedia/search/bloc/bloc.dart';
import 'package:socialmedia/search/search.dart';
import 'package:socialmedia/timeline/timeline.dart';
import 'package:socialmedia/upload/bloc/bloc.dart';
import 'package:socialmedia/upload/upload.dart';

class Home extends StatelessWidget {
  final FirestoreRepo firestoreRepo;
  const Home({Key key, this.firestoreRepo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User user =
        (BlocProvider.of<AuthBloc>(context).state as Authenticated).user;
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
          case 1:
            return const ActivityFeed();
          case 2:
            return BlocProvider<UploadBloc>(
              create: (context) => UploadBloc(),
              child: Upload(),
            );
          case 3:
            return BlocProvider<SearchBloc>(
              create: (context) => SearchBloc(firestoreRepo: firestoreRepo),
              child: Search(),
            );
          case 4:
            return BlocProvider<ProfileBloc>(
              create: (context) => ProfileBloc(firestoreRepo: firestoreRepo)
                ..add(LoadPosts(userId: user.id)),
              child: Profile(
                user: user,
                profileId: user.id,
              ),
            );

          default:
            return const Timeline();
        }
      },
    );
  }
}

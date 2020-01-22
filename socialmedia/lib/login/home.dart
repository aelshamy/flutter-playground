import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/auth/bloc/bloc.dart';
import 'package:socialmedia/common/model/user.dart';
import 'package:socialmedia/feed/activity_feed.dart';
import 'package:socialmedia/profile/bloc/bloc.dart';
import 'package:socialmedia/profile/profile.dart';
import 'package:socialmedia/repo/firestore_repo.dart';
import 'package:socialmedia/repo/storage_repo.dart';
import 'package:socialmedia/search/bloc/bloc.dart';
import 'package:socialmedia/search/search.dart';
import 'package:socialmedia/timeline/timeline.dart';
import 'package:socialmedia/upload/bloc/bloc.dart';
import 'package:socialmedia/upload/upload.dart';

class Home extends StatefulWidget {
  final FirestoreRepo firestoreRepo;
  const Home({Key key, this.firestoreRepo}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  User user;
  final _pageController = PageController(initialPage: 0);
  List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    user = (BlocProvider.of<AuthBloc>(context).state as Authenticated).user;
    _pages = [
      const Timeline(),
      const ActivityFeed(),
      BlocProvider<UploadBloc>(
        create: (context) => UploadBloc(storageRepo: StorageRepo(fireStoreRepo: widget.firestoreRepo)),
        child: Upload(),
      ),
      BlocProvider<SearchBloc>(
        create: (context) => SearchBloc(firestoreRepo: widget.firestoreRepo),
        child: Search(),
      ),
      BlocProvider<ProfileBloc>(
        create: (context) => ProfileBloc(firestoreRepo: widget.firestoreRepo)..add(LoadPosts(userId: user.id)),
        child: Profile(user: user, profileId: user.id),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: onPageChanged,
        children: _pages,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        onTap: navigateToPage,
        height: 50,
        index: _currentIndex,
        backgroundColor: Theme.of(context).accentColor,
        color: Colors.grey.shade100,
        buttonBackgroundColor: Colors.white,
        items: <Widget>[
          Icon(Icons.whatshot),
          Icon(Icons.notifications_active),
          Icon(Icons.photo_camera, size: 30),
          Icon(Icons.search),
          Icon(Icons.account_circle),
        ],
        // onTap: navigateToPage,
        // currentIndex: _page,
      ),
    );
  }

  void navigateToPage(int page) {
    _pageController.animateToPage(page, duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  void onPageChanged(int page) {
    setState(() {
      _currentIndex = page;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
}

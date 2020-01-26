import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/auth/bloc/bloc.dart';
import 'package:socialmedia/common/model/user.dart';
import 'package:socialmedia/common/widgets/route_aware_widget.dart';
import 'package:socialmedia/feed/activity_feed.dart';
import 'package:socialmedia/feed/bloc/bloc.dart';
import 'package:socialmedia/feed/bloc/feed_bloc.dart';
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
  PageController _pageController;
  CircularBottomNavigationController _circularBottomNavigationController;
  List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
    _circularBottomNavigationController = CircularBottomNavigationController(_currentIndex);
    user = (BlocProvider.of<AuthBloc>(context).state as Authenticated).user;
    _pages = [
      const Timeline(),
      BlocProvider<FeedBloc>(
        create: (context) =>
            FeedBloc(firestoreRepo: widget.firestoreRepo)..add(LoadFeed(userId: user.id)),
        child: const ActivityFeed(),
      ),
      BlocProvider<UploadBloc>(
        create: (context) =>
            UploadBloc(storageRepo: StorageRepo(fireStoreRepo: widget.firestoreRepo)),
        child: Upload(),
      ),
      BlocProvider<SearchBloc>(
        create: (context) => SearchBloc(firestoreRepo: widget.firestoreRepo),
        child: RouteAwareWidget('search', child: Search()),
      ),
      BlocProvider<ProfileBloc>(
        create: (context) =>
            ProfileBloc(firestoreRepo: widget.firestoreRepo)..add(LoadPosts(userId: user.id)),
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
      bottomNavigationBar: CircularBottomNavigation(
        [
          TabItem(Icons.list, "Home", Colors.cyan),
          TabItem(Icons.notifications, "Feed", Colors.cyan),
          TabItem(Icons.photo_camera, "Photo", Colors.red),
          TabItem(Icons.search, "Search", Colors.cyan),
          TabItem(Icons.person, "Account", Colors.cyan),
        ],
        barHeight: 50,
        selectedCallback: navigateToPage,
        // height: 50,
        // index: _currentIndex,
        // selectedIconColor: Theme.of(context).accentColor,
        selectedIconColor: Colors.white,
        barBackgroundColor: Colors.white,
        controller: _circularBottomNavigationController,
        // buttonBackgroundColor: Colors.white,
      ),
    );
  }

  void navigateToPage(int page) {
    _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
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

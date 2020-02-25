import 'package:circle_bottom_navigation/circle_bottom_navigation.dart';
import 'package:circle_bottom_navigation/widgets/tab_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/auth/bloc/bloc.dart';
import 'package:socialmedia/common/model/user.dart';
import 'package:socialmedia/common/widgets/route_aware_widget.dart';
import 'package:socialmedia/notifications/bloc/notifications_bloc.dart';
import 'package:socialmedia/notifications/notifications_page.dart';
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
  List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
    user = (BlocProvider.of<AuthBloc>(context).state as Authenticated).user;
    _pages = [
      const RouteAwareWidget("Timeline", child: Timeline()),
      BlocProvider<NotificationsBloc>(
        create: (context) => NotificationsBloc(firestoreRepo: widget.firestoreRepo)
          ..add(LoadNotifications(userId: user.id)),
        child: const RouteAwareWidget("ActivityFeed", child: NotificationPage()),
      ),
      BlocProvider<UploadBloc>(
        create: (context) =>
            UploadBloc(storageRepo: StorageRepo(fireStoreRepo: widget.firestoreRepo)),
        child: RouteAwareWidget("Upload", child: Upload()),
      ),
      BlocProvider<SearchBloc>(
        create: (context) => SearchBloc(firestoreRepo: widget.firestoreRepo),
        child: RouteAwareWidget("Search", child: Search()),
      ),
      BlocProvider<ProfileBloc>(
        create: (context) =>
            ProfileBloc(firestoreRepo: widget.firestoreRepo)..add(LoadPosts(userId: user.id)),
        child: RouteAwareWidget("Profile", child: Profile(user: user)),
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
      bottomNavigationBar: CircleBottomNavigation(
        initialSelection: _currentIndex,
        tabs: [
          TabData(icon: Icons.list, title: "Home"),
          TabData(icon: Icons.notifications, title: "Feed"),
          TabData(icon: Icons.photo_camera, title: "Photo"),
          TabData(icon: Icons.search, title: "Search"),
          TabData(icon: Icons.person, title: "Account"),
        ],
        onTabChangedListener: navigateToPage,
        circleSize: 50,
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

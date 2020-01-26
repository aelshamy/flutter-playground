import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/common/custom_route_observer.dart';
import 'package:socialmedia/login/home.dart';
import 'package:socialmedia/login/login.dart';
import 'package:socialmedia/login/splash_screen.dart';
import 'package:socialmedia/repo/firestore_repo.dart';

import 'auth/bloc/bloc.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class App extends StatelessWidget {
  final FirestoreRepo firestoreRepo;

  const App({Key key, this.firestoreRepo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Social Media',
      debugShowCheckedModeBanner: false,
      navigatorObservers: [CustomRouteObserver(), routeObserver],
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        accentColor: Colors.cyan,
      ),
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (BuildContext context, AuthState state) {
          if (state is Uninitialized) {
            return const SplashScreen();
          }
          if (state is Authenticated) {
            return Home(firestoreRepo: firestoreRepo);
          }
          if (state is Unauthenticated) {
            return const Login();
          }
          return const SizedBox();
        },
      ),
    );
  }
}

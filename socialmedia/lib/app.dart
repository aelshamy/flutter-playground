import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/common/blocs/auth/auth_bloc.dart';
import 'package:socialmedia/common/custom_route_observer.dart';
import 'package:socialmedia/login/home.dart';
import 'package:socialmedia/login/login.dart';
import 'package:socialmedia/login/splash_screen.dart';
import 'package:socialmedia/repo/firestore_repo.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Social Media',
      debugShowCheckedModeBanner: false,
      navigatorObservers: [CustomRouteObserver(), routeObserver],
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        accentColor: Colors.redAccent,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (BuildContext context, AuthState state) {
          if (state is Uninitialized) {
            return const SplashScreen();
          }
          if (state is Authenticated) {
            return Home(firestoreRepo: RepositoryProvider.of<FirestoreRepo>(context));
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

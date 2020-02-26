import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/common/blocs/user/user_bloc.dart';
import 'package:socialmedia/common/custom_route_observer.dart';
import 'package:socialmedia/login/create_account.dart';
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
      home: BlocBuilder<UserBloc, UserState>(
        builder: (BuildContext context, UserState state) {
          if (state is UserUninitialized) {
            return const SplashScreen();
          }
          if (state is UserAuthenticated) {
            return Home(firestoreRepo: RepositoryProvider.of<FirestoreRepo>(context));
          }
          if (state is UserUnauthenticated) {
            return const Login();
          }
          if (state is UserNotExists) {
            return const CreateAccount();
          }
          return const SizedBox();
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'authentication_bloc/bloc.dart';
import 'common/simple_bloc_delegate.dart';
import 'login/home.dart';
import 'login/login.dart';
import 'login/splash_screen.dart';
import 'repo/user_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final UserRepository userRepository = UserRepository();
  runApp(
    BlocProvider(
      create: (BuildContext context) =>
          AuthenticationBloc(userRepository: userRepository)..add(AppStarted()),
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Social Media',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        accentColor: Colors.teal,
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (BuildContext context, AuthenticationState state) {
          if (state is Uninitialized) {
            return SplashScreen();
          }
          if (state is Unauthenticated) {
            return Login();
          }
          if (state is Authenticated) {
            return Home();
          }
          return SizedBox();
        },
      ),
    );
  }
}

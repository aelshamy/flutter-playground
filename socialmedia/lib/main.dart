import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/auth/bloc/auth_event.dart';
import 'package:socialmedia/auth/bloc/bloc.dart';
import 'package:socialmedia/repo/firestore_repo.dart';

import 'auth/bloc/auth_state.dart';
import 'common/simple_bloc_delegate.dart';
import 'login/bloc/bloc.dart';
import 'login/home.dart';
import 'login/login.dart';
import 'login/splash_screen.dart';
import 'repo/user_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final UserRepository userRepository = UserRepository();
  final FirestoreRepo firestoreRepo = FirestoreRepo();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (BuildContext context) => AuthBloc(userRepository: userRepository, firestoreRepo: firestoreRepo)..add(AppStarted()),
        ),
        BlocProvider<LoginBloc>(
          create: (BuildContext context) => LoginBloc(
            userRepository: userRepository,
          ),
        ),
      ],
      child: App(firestoreRepo: firestoreRepo),
    ),
  );
}

class App extends StatelessWidget {
  final FirestoreRepo firestoreRepo;

  const App({Key key, this.firestoreRepo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Social Media',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        accentColor: Colors.teal,
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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/app.dart';
import 'package:socialmedia/auth/bloc/auth_event.dart';
import 'package:socialmedia/auth/bloc/bloc.dart';
import 'package:socialmedia/repo/firestore_repo.dart';

import 'common/simple_bloc_delegate.dart';
import 'login/bloc/bloc.dart';

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
          create: (BuildContext context) => AuthBloc(
              userRepository: userRepository, firestoreRepo: firestoreRepo)
            ..add(AppStarted()),
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

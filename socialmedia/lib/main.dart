import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/app.dart';
import 'package:socialmedia/common/blocs/auth/auth_bloc.dart';
import 'package:socialmedia/login/bloc/login_bloc.dart';
import 'package:socialmedia/repo/firestore_repo.dart';

import 'common/simple_bloc_delegate.dart';
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
  final FirestoreRepo firestoreepository = FirestoreRepo();
  final AuthBloc authBloc =
      AuthBloc(userRepository: userRepository, firestoreRepo: firestoreepository);
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserRepository>(
          create: (context) => userRepository,
        ),
        RepositoryProvider<FirestoreRepo>(
          create: (context) => firestoreepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (BuildContext context) => authBloc..add(AppStarted()),
          ),
          BlocProvider<LoginBloc>(
            create: (BuildContext context) =>
                LoginBloc(userRepository: userRepository, authBloc: authBloc),
          ),
        ],
        child: App(),
      ),
    ),
  );
}

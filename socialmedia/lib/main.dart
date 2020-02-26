import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/app.dart';
import 'package:socialmedia/common/blocs/user/user_bloc.dart';
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
      child: BlocProvider<UserBloc>(
        create: (BuildContext context) =>
            UserBloc(userRepository: userRepository, firestoreRepo: firestoreepository)
              ..add(AppStarted()),
        child: App(),
      ),
    ),
  );
}

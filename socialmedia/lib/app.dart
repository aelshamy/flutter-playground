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
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Social Media',
      debugShowCheckedModeBanner: false,
      navigatorObservers: [CustomRouteObserver(), routeObserver],
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple)
            .copyWith(secondary: Colors.redAccent),
      ),
      home: BlocConsumer<UserBloc, UserState>(
        listener: (BuildContext context, UserState state) {
          if (state is UserError) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                // return object of type Dialog
                return AlertDialog(
                  title: const Text("There was a problem"),
                  content: Text(state.error),
                  actions: <Widget>[
                    // usually buttons at the bottom of the dialog
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Close"),
                    ),
                  ],
                );
              },
            );
          }
        },
        buildWhen: (UserState prev, UserState current) => current is! UserError,
        builder: (BuildContext context, UserState state) {
          if (state is UserLoadding) {
            return const SplashScreen();
          } else if (state is UserAuthenticated) {
            return Home(
                firestoreRepo: RepositoryProvider.of<FirestoreRepo>(context));
          } else if (state is UserNotAuthenticated) {
            return const Login();
          } else if (state is UserDoesNotExists) {
            return const CreateAccount();
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

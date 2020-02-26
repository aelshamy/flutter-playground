import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/common/blocs/user/user_bloc.dart';
import 'package:socialmedia/login/bloc/login_bloc.dart';

import 'create_account.dart';

class Login extends StatelessWidget {
  const Login({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (BuildContext context, LoginState state) {
        if (state is UserLoggedIn) {
          BlocProvider.of<UserBloc>(context).add(LoggedIn(user: state.user));
        }
      },
      bloc: BlocProvider.of<LoginBloc>(context),
      builder: (BuildContext context, LoginState state) {
        if (state is LoginCreateUser) {
          return const CreateAccount();
        }
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: <Color>[
                  Theme.of(context).accentColor,
                  Theme.of(context).primaryColor,
                ],
              ),
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'FlutterShare',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 90,
                    fontFamily: 'Signatra',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<LoginBloc>(context).add(LoginWithGoogle());
                  },
                  child: Container(
                    width: 260,
                    height: 60,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/google_signin_button.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

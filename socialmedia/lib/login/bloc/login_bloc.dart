import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia/common/blocs/auth/auth_bloc.dart';
import 'package:socialmedia/common/model/user.dart';
import 'package:socialmedia/repo/user_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthBloc authBloc;

  StreamSubscription _userSubscription;

  LoginBloc({@required this.userRepository, @required this.authBloc})
      : assert(userRepository != null, authBloc != null);

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginWithGoogle) {
      yield* _mapLoginWithGoogleToState();
    }
    if (event is StartCreateUser) {
      yield* _mapStartCreateuserToState();
    }
    if (event is Createuser) {
      yield* _mapCreateuserToState(event.username);
    }
    if (event is Logout) {
      yield* _mapLogoutToState();
    }
  }

  Stream<LoginState> _mapLoginWithGoogleToState() async* {
    yield LoginLoading();
    try {
      await userRepository.signInWithGoogle();
      _userSubscription?.cancel();
      _userSubscription = userRepository.getUser().listen((doc) {
        if (!doc.exists) {
          add(StartCreateUser());
        } else {
          authBloc.add(LoggedIn(user: User.fromDocument(doc)));
        }
      });
    } catch (e) {
      yield LoginFailure(error: e.toString());
    }
  }

  Stream<LoginState> _mapStartCreateuserToState() async* {
    yield LoginCreateUser();
  }

  Stream<LoginState> _mapCreateuserToState(String username) async* {
    try {
      final User user = await userRepository.createUser(username);
      authBloc.add(LoggedIn(user: user));
      yield LoginInitial();
    } catch (e) {
      yield LoginFailure(error: e.toString());
    }
  }

  Stream<LoginState> _mapLogoutToState() async* {
    try {
      await userRepository.signOut();
      authBloc.add(LoggedOut());
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<void> close() {
    authBloc.close();
    _userSubscription.cancel();
    return super.close();
  }
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia/common/model/user.dart';
import 'package:socialmedia/repo/user_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;

  StreamSubscription _userSubscription;

  LoginBloc({@required this.userRepository}) : assert(userRepository != null);

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
      yield LoginCreateUser();
    }
    if (event is AuthenticateUser) {
      yield UserLoggedIn(user: event.user);
    }
    if (event is Createuser) {
      yield* _mapCreateuserToState(event.username);
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
          add(AuthenticateUser(user: User.fromDocument(doc)));
        }
      });
    } catch (e) {
      yield LoginFailure(error: e.toString());
    }
  }

  Stream<LoginState> _mapCreateuserToState(String username) async* {
    try {
      final User user = await userRepository.createUser(username);
      yield UserLoggedIn(user: user);
    } catch (e) {
      yield LoginFailure(error: e.toString());
    }
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}

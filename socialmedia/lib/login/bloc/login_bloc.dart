import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia/auth/bloc/bloc.dart';
import 'package:socialmedia/common/model/user.dart';
import 'package:socialmedia/repo/user_repository.dart';

import './bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository _userRepository;
  final AuthBloc _authBloc;

  LoginBloc(
      {@required UserRepository userRepository, @required AuthBloc authBloc})
      : _userRepository = userRepository ?? UserRepository(),
        _authBloc = authBloc ?? AuthBloc(userRepository: userRepository);

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginWithGoogle) {
      yield* _mapLoginWithGoogleToState();
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
      await _userRepository.signInWithGoogle();
      final doc = await _userRepository.getUser();
      if (!doc.exists) {
        yield LoginCreateUser();
      } else {
        _authBloc.add(LoggedIn(user: User.fromDocument(doc)));
        yield LoginInitial();
      }
    } catch (e) {
      yield LoginFailure(error: e.toString());
    }
  }

  Stream<LoginState> _mapCreateuserToState(String username) async* {
    try {
      final User user = await _userRepository.createUser(username);
      _authBloc.add(LoggedIn(user: user));
      yield LoginInitial();
    } catch (e) {
      yield LoginFailure(error: e.toString());
    }
  }

  Stream<LoginState> _mapLogoutToState() async* {
    try {
      await _userRepository.signOut();
      _authBloc.add(LoggedOut());
    } catch (e) {
      print(e);
    }
  }
}

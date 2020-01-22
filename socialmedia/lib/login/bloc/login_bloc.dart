import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia/auth/bloc/bloc.dart';
import 'package:socialmedia/common/model/user.dart';
import 'package:socialmedia/repo/user_repository.dart';

import './bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository _userRepository;
  final AuthBloc _authBloc;

  StreamSubscription _userSubscription;

  LoginBloc({@required UserRepository userRepository, @required AuthBloc authBloc})
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
      await _userRepository.signInWithGoogle();
      _userSubscription?.cancel();
      _userSubscription = _userRepository.getUser().listen((doc) {
        if (!doc.exists) {
          add(StartCreateUser());
        } else {
          _authBloc.add(LoggedIn(user: User.fromDocument(doc)));
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
      log(e.toString());
    }
  }

  @override
  Future<void> close() {
    _authBloc.close();
    _userSubscription.cancel();
    return super.close();
  }
}

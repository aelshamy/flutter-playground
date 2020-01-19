import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:socialmedia/model/user.dart';
import 'package:socialmedia/repo/user_repository.dart';

import 'bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository _userRepository;

  AuthBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  AuthState get initialState => Uninitialized();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthState> _mapAppStartedToState() async* {
    // try {
    //   await _userRepository.signInSilentlyWithGoogle();
    //   final doc = await _userRepository.getUser();
    //   yield Authenticated(User.fromDocument(doc));
    // } catch (_) {
    yield Unauthenticated();
    // }
  }

  Stream<AuthState> _mapLoggedInToState() async* {
    final doc = await _userRepository.getUser();
    yield Authenticated(User.fromDocument(doc));
  }

  Stream<AuthState> _mapLoggedOutToState() async* {
    await _userRepository.signOut();
    yield Unauthenticated();
  }
}

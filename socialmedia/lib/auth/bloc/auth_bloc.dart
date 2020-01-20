import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:socialmedia/common/model/user.dart';
import 'package:socialmedia/repo/firestore_repo.dart';
import 'package:socialmedia/repo/user_repository.dart';

import 'bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository _userRepository;
  final FirestoreRepo _firestoreRepo;

  AuthBloc(
      {@required UserRepository userRepository, FirestoreRepo firestoreRepo})
      : assert(userRepository != null, firestoreRepo != null),
        _userRepository = userRepository,
        _firestoreRepo = firestoreRepo;

  @override
  AuthState get initialState => Uninitialized();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState(event.user);
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    } else if (event is UpdateUser) {
      yield* _mapUpdateUserToState(event.userId, event.displayName, event.bio);
    }
  }

  Stream<AuthState> _mapAppStartedToState() async* {
    try {
      await _userRepository.signInSilentlyWithGoogle();
      final doc = await _userRepository.getUser();
      yield Authenticated(user: User.fromDocument(doc));
    } catch (_) {
      yield Unauthenticated();
    }
  }

  Stream<AuthState> _mapLoggedInToState(User user) async* {
    yield Authenticated(user: user);
  }

  Stream<AuthState> _mapLoggedOutToState() async* {
    await _userRepository.signOut();
    yield Unauthenticated();
  }

  Stream<AuthState> _mapUpdateUserToState(
      String userId, String displayName, String bio) async* {
    await _firestoreRepo.updateUser(userId, displayName, bio);
  }
}

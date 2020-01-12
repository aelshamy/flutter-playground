import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:socialmedia/repo/user_repository.dart';

import './bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository _userRepository;

  LoginBloc({UserRepository userRepository}) : _userRepository = userRepository ?? UserRepository();

  @override
  LoginState get initialState => InitialLogin();

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
  }

  Stream<LoginState> _mapLoginWithGoogleToState() async* {
    try {
      await _userRepository.signInWithGoogle();
      final doc = await _userRepository.getUser();
      if (!doc.exists) {
        yield UserNotCreated();
      } else {
        yield LoginSuccessfully();
      }
    } catch (_) {
      yield LoginError();
    }
  }

  Stream<LoginState> _mapCreateuserToState(String username) async* {
    try {
      await _userRepository.createUser(username);
      yield UserCreated();
    } catch (e) {
      print(e);
      yield UserCreationError();
    }
  }
}

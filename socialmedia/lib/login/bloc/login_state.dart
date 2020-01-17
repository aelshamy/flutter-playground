import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class LoginState extends Equatable {
  final List _props;
  const LoginState([this._props]);
  @override
  List<Object> get props => this._props;
}

class InitialLogin extends LoginState {
  @override
  String toString() => 'Initial';

  @override
  List<Object> get props => [];
}

class LoginSuccessfully extends LoginState {
  @override
  String toString() => 'Login successfully with google';

  @override
  List<Object> get props => [];
}

class UserNotCreated extends LoginState {
  @override
  String toString() => 'User not created';

  @override
  List<Object> get props => [];
}

class UserCreated extends LoginState {
  @override
  String toString() => 'User created';

  @override
  List<Object> get props => [];
}

class LoginError extends LoginState {
  @override
  String toString() => 'Login error';

  @override
  List<Object> get props => [];
}

class UserCreationError extends LoginState {
  @override
  String toString() => 'User creation error';

  @override
  List<Object> get props => [];
}

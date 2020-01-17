import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class LoginState extends Equatable {
  final List _props;
  const LoginState([this._props]);
  @override
  List<Object> get props => this._props;
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginCreateUser extends LoginState {}

class LoginFailure extends LoginState {
  final String error;

  const LoginFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LoginFailure { error: $error }';
}

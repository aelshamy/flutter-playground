import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:socialmedia/common/model/user.dart';

@immutable
abstract class AuthState extends Equatable {
  const AuthState();
}

class Uninitialized extends AuthState {
  @override
  List<Object> get props => [];
}

class Authenticated extends AuthState {
  final User user;

  const Authenticated({this.user});

  @override
  String toString() => 'Authenticated: $user';

  @override
  List<Object> get props => [user];
}

class Unauthenticated extends AuthState {
  @override
  List<Object> get props => [];
}

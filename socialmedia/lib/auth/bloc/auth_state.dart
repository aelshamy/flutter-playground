import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:socialmedia/model/user.dart';

@immutable
abstract class AuthState extends Equatable {
  const AuthState([List props = const []]);

  @override
  List<Object> get props => this.props;
}

class Uninitialized extends AuthState {
  @override
  String toString() => 'Uninitialized';

  @override
  List<Object> get props => [];
}

class Authenticated extends AuthState {
  final User user;

  Authenticated(this.user) : super([user]);

  @override
  String toString() => 'Authenticated: $user';

  @override
  List<Object> get props => [this.user];
}

class Unauthenticated extends AuthState {
  @override
  String toString() => 'Unauthenticated';

  @override
  List<Object> get props => [];
}

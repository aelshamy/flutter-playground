import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent([List props = const []]);

  @override
  List<Object> get props => [];
}

class LoginWithGoogle extends LoginEvent {
  @override
  String toString() => 'Login With Google';
}

class Createuser extends LoginEvent {
  final String username;

  Createuser(this.username) : super([username]);

  @override
  String toString() => 'User created';

  @override
  List<Object> get props => [];
}

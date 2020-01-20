import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent([List _props = const []]);
}

class LoginWithGoogle extends LoginEvent {
  @override
  List<Object> get props => [];
}

class Logout extends LoginEvent {
  @override
  List<Object> get props => [];
}

class Createuser extends LoginEvent {
  final String username;

  Createuser(this.username) : super([username]);

  @override
  List<Object> get props => [username];
}

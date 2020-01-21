import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
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

  const Createuser(this.username);

  @override
  List<Object> get props => [username];
}

class StartCreateUser extends LoginEvent {
  @override
  List<Object> get props => [];
}

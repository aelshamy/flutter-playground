part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginWithGoogle extends LoginEvent {
  @override
  List<Object> get props => [];
}

class AuthenticateUser extends LoginEvent {
  final User user;

  const AuthenticateUser({this.user});
  @override
  List<Object> get props => [user];
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

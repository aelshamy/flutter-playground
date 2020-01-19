import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  final List<Object> _props;
  const LoginEvent([this._props]);

  @override
  List<Object> get props => this._props;
}

class LoginWithGoogle extends LoginEvent {}

class Logout extends LoginEvent {}

class Createuser extends LoginEvent {
  final String username;

  Createuser(this.username) : super([username]);

  @override
  List<Object> get props => [username];
}

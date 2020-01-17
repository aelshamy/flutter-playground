import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  final List<Object> _props;
  const LoginEvent([this._props]);

  @override
  List<Object> get props => this._props;
}

class LoginWithGoogle extends LoginEvent {
  @override
  String toString() => 'Login With Google';
}

class Createuser extends LoginEvent {
  final String username;

  Createuser(this.username) : super([username]);

  @override
  String toString() => 'Create User';

  @override
  List<Object> get props => [];
}

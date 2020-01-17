import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  final List _props;
  const AuthEvent([this._props]);

  @override
  List<Object> get props => this._props;
}

class AppStarted extends AuthEvent {
  @override
  String toString() => 'AppStarted';
}

class LoggedIn extends AuthEvent {
  @override
  String toString() => 'LoggedIn';
}

class LoggedOut extends AuthEvent {
  @override
  String toString() => 'LoggedOut';
}

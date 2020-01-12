import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent([List props = const []]);

  @override
  List<Object> get props => this.props;
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

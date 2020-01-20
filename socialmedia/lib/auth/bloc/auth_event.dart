import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class AppStarted extends AuthEvent {
  @override
  List<Object> get props => [];
}

class LoggedIn extends AuthEvent {
  @override
  List<Object> get props => [];
}

class LoggedOut extends AuthEvent {
  @override
  List<Object> get props => [];
}

class UpdateUser extends AuthEvent {
  final String userId;
  final String bio;
  final String displayName;

  const UpdateUser({
    this.userId,
    this.bio,
    this.displayName,
  });

  @override
  List<Object> get props => [userId, bio, displayName];
}

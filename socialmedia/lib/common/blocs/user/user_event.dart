part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class AppStarted extends UserEvent {
  @override
  List<Object> get props => [];
}

class LoggedIn extends UserEvent {
  final User user;

  const LoggedIn({this.user});
  @override
  List<Object> get props => [user];
}

class LoggedOut extends UserEvent {
  @override
  List<Object> get props => [];
}

class UpdateUser extends UserEvent {
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

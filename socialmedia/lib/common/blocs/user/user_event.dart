part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class AppStarted extends UserEvent {
  @override
  List<Object> get props => [];
}

class LoginWithGoogle extends UserEvent {
  @override
  List<Object> get props => [];
}

class CreateUser extends UserEvent {
  @override
  List<Object> get props => [];
}

class CreateUsername extends UserEvent {
  final String username;

  const CreateUsername(this.username);

  @override
  List<Object> get props => [username];
}

class LoginUser extends UserEvent {
  final User user;

  const LoginUser({this.user});
  @override
  List<Object> get props => [user];
}

class LogoutUser extends UserEvent {
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

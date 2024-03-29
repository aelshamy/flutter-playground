part of 'user_bloc.dart';

@immutable
abstract class UserState extends Equatable {
  const UserState();
}

class UserLoadding extends UserState {
  @override
  List<Object> get props => [];
}

class UserDoesNotExists extends UserState {
  @override
  List<Object> get props => [];
}

class UserNotAuthenticated extends UserState {
  @override
  List<Object> get props => [];
}

class UserAuthenticated extends UserState {
  final User user;

  const UserAuthenticated({this.user});

  @override
  String toString() => 'Authenticated: $user';

  @override
  List<Object> get props => [user];
}

class UserError extends UserState {
  final String error;

  const UserError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LoginFailure { error: $error }';
}

part of 'user_bloc.dart';

@immutable
abstract class UserState extends Equatable {
  const UserState();
}

class Uninitialized extends UserState {
  @override
  List<Object> get props => [];
}

class Authenticated extends UserState {
  final User user;

  const Authenticated({this.user});

  @override
  String toString() => 'Authenticated: $user';

  @override
  List<Object> get props => [user];
}

class Unauthenticated extends UserState {
  @override
  List<Object> get props => [];
}

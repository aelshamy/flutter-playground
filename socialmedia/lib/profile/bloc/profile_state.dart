part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

class ProfileLoading extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileLoadError extends ProfileState {
  final String error;

  const ProfileLoadError({this.error});

  @override
  List<Object> get props => [error];
}

class ProfileLoaded extends ProfileState {
  final List<Post> posts;

  const ProfileLoaded({this.posts});

  @override
  List<Object> get props => [posts];
}

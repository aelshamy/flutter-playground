import 'package:equatable/equatable.dart';
import 'package:socialmedia/common/model/post.dart';

abstract class ProfileState extends Equatable {
  const ProfileState([List _props = const <dynamic>[]]);
}

class ProfileInitial extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileLoading extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileLoadError extends ProfileState {
  final String error;
  ProfileLoadError({this.error}) : super(<dynamic>[error]);
  @override
  List<Object> get props => [];
}

class ProfileLoaded extends ProfileState {
  final List<Post> posts;

  ProfileLoaded({this.posts}) : super(<dynamic>[posts]);

  @override
  List<Object> get props => [];
}

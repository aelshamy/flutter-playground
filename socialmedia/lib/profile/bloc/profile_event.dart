import 'package:equatable/equatable.dart';
import 'package:socialmedia/common/model/post.dart';
import 'package:socialmedia/common/model/user.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class LoadPosts extends ProfileEvent {
  final String userId;

  const LoadPosts({this.userId});

  @override
  List<Object> get props => [userId];
}

class PostsLoaded extends ProfileEvent {
  final List<Post> posts;

  const PostsLoaded({this.posts});

  @override
  List<Object> get props => [posts];
}

class LikePost extends ProfileEvent {
  final Post post;
  final User user;

  const LikePost({this.post, this.user});

  @override
  List<Object> get props => [post, user];
}

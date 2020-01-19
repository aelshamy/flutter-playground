import 'package:equatable/equatable.dart';
import 'package:socialmedia/common/model/post.dart';
import 'package:socialmedia/common/model/user.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent([List props = const <dynamic>[]]);
}

class LoadPosts extends ProfileEvent {
  final String userId;

  LoadPosts({this.userId}) : super(<dynamic>[userId]);

  @override
  List<Object> get props => [userId];
}

class LikePost extends ProfileEvent {
  final Post post;
  final User user;

  LikePost({this.post, this.user}) : super(<dynamic>[post, user]);

  @override
  List<Object> get props => [post, user];
}

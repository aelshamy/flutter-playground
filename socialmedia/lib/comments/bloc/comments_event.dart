import 'package:equatable/equatable.dart';
import 'package:socialmedia/common/model/comment.dart';
import 'package:socialmedia/common/model/post.dart';
import 'package:socialmedia/common/model/user.dart';

abstract class CommentsEvent extends Equatable {
  const CommentsEvent();
}

class AddComment extends CommentsEvent {
  final Post post;
  final User user;
  final String comment;

  const AddComment({this.post, this.user, this.comment});

  @override
  List<Object> get props => [post, user, comment];
}

class LoadComments extends CommentsEvent {
  final String postId;

  const LoadComments({this.postId});
  @override
  List<Object> get props => [postId];
}

class CommentsLoaded extends CommentsEvent {
  final List<Comment> comments;

  const CommentsLoaded({this.comments});

  @override
  List<Object> get props => [comments];
}

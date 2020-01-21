import 'package:equatable/equatable.dart';
import 'package:socialmedia/common/model/comment.dart';

abstract class CommentsState extends Equatable {
  const CommentsState();
}

class CommentsLoading extends CommentsState {
  @override
  List<Object> get props => [];
}

class CommentsRecieved extends CommentsState {
  final List<Comment> comments;

  const CommentsRecieved({this.comments});

  @override
  List<Object> get props => [comments];
}

class CommentsLoadError extends CommentsState {
  final String error;

  const CommentsLoadError({this.error});
  @override
  List<Object> get props => [error];
}

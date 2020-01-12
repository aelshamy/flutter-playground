import 'package:equatable/equatable.dart';

abstract class CommentsState extends Equatable {
  const CommentsState();
}

class InitialCommentsState extends CommentsState {
  @override
  List<Object> get props => [];
}

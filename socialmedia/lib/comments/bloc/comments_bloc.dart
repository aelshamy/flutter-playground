import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:socialmedia/common/model/comment.dart';
import 'package:socialmedia/common/model/post.dart';
import 'package:socialmedia/common/model/user.dart';
import 'package:socialmedia/repo/firestore_repo.dart';

part 'comments_event.dart';
part 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  final FirestoreRepo firestoreRepo;
  StreamSubscription _commentsSubscription;

  CommentsBloc({@required this.firestoreRepo}) : assert(firestoreRepo != null);
  @override
  CommentsState get initialState => CommentsLoading();

  @override
  Stream<CommentsState> mapEventToState(
    CommentsEvent event,
  ) async* {
    if (event is LoadComments) {
      yield* _mapLoadCommentsToState(event.postId);
    }
    if (event is CommentsLoaded) {
      yield* _mapCommentsLoadedToState(event.comments);
    }
    if (event is AddComment) {
      yield* _mapAddCommentToState(event);
    }
  }

  Stream<CommentsState> _mapLoadCommentsToState(String postId) async* {
    try {
      _commentsSubscription?.cancel();
      _commentsSubscription = firestoreRepo.getPostComments(postId).listen(
            (comments) => add(CommentsLoaded(comments: comments)),
          );
    } catch (e) {
      yield CommentsLoadError(error: e.toString());
    }
  }

  Stream<CommentsState> _mapCommentsLoadedToState(List<Comment> comments) async* {
    yield CommentsRecieved(comments: comments);
  }

  Stream<CommentsState> _mapAddCommentToState(AddComment event) async* {
    await firestoreRepo.addComment(event.post, event.user, event.comment);
    // if (event.post.owner != event.user.id) {
    await firestoreRepo.addCommentToFeed(event.post, event.user, event.comment);
    // }
  }

  @override
  Future<void> close() {
    _commentsSubscription.cancel();
    return super.close();
  }
}

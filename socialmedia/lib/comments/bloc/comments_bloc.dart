import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:socialmedia/common/model/comment.dart';
import 'package:socialmedia/repo/firestore_repo.dart';
import './bloc.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  final FirestoreRepo _firestoreRepo;
  StreamSubscription _commentsSubscription;

  CommentsBloc({FirestoreRepo firestoreRepo})
      : _firestoreRepo = firestoreRepo ?? FirestoreRepo();
  @override
  CommentsState get initialState => CommentsInitial();

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
    yield CommentsLoading();
    try {
      _commentsSubscription?.cancel();
      _commentsSubscription = _firestoreRepo.getPostComments(postId).listen(
            (comments) => add(CommentsLoaded(comments: comments)),
          );
    } catch (e) {
      yield CommentsLoadError(error: e.toString());
    }
  }

  Stream<CommentsState> _mapCommentsLoadedToState(
      List<Comment> comments) async* {
    yield CommentsRecieved(comments: comments);
  }

  Stream<CommentsState> _mapAddCommentToState(AddComment event) async* {
    _firestoreRepo.addComment(event.postId, event.user, event.comment);
  }

  @override
  Future<void> close() {
    _commentsSubscription.cancel();
    return super.close();
  }
}

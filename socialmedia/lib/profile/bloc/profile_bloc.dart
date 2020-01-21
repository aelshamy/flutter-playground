import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:socialmedia/common/model/post.dart';
import 'package:socialmedia/common/model/user.dart';
import 'package:socialmedia/repo/firestore_repo.dart';

import './bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final FirestoreRepo _firestoreRepo;
  StreamSubscription _todosSubscription;

  ProfileBloc({FirestoreRepo firestoreRepo})
      : _firestoreRepo = firestoreRepo ?? FirestoreRepo();

  @override
  ProfileState get initialState => ProfileInitial();

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is LoadPosts) {
      yield* _mapLoadPostsToState(event.userId);
    }
    if (event is PostsLoaded) {
      yield* _mapPostsLoadedToState(event.posts);
    }
    if (event is LikePost) {
      yield* _mapLikePostToState(event.post, event.user);
    }
  }

  Stream<ProfileState> _mapLoadPostsToState(String userId) async* {
    yield ProfileLoading();
    try {
      _todosSubscription?.cancel();
      _todosSubscription = _firestoreRepo.getUserPosts(userId).listen(
            (posts) => add(PostsLoaded(posts: posts)),
          );
    } catch (e) {
      yield ProfileLoadError(error: e.toString());
    }
  }

  Stream<ProfileState> _mapPostsLoadedToState(
    List<Post> posts,
  ) async* {
    yield ProfileLoaded(posts: posts);
  }

  Stream<ProfileState> _mapLikePostToState(Post post, User user) async* {
    await _firestoreRepo.likePost(post, user);
  }

  @override
  Future<void> close() {
    _todosSubscription?.cancel();
    return super.close();
  }
}

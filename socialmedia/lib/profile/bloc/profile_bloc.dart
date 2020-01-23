import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:socialmedia/common/model/post.dart';
import 'package:socialmedia/common/model/user.dart';
import 'package:socialmedia/repo/firestore_repo.dart';

import './bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final FirestoreRepo _firestoreRepo;
  StreamSubscription _postsSubscription;

  ProfileBloc({FirestoreRepo firestoreRepo}) : _firestoreRepo = firestoreRepo ?? FirestoreRepo();

  @override
  ProfileState get initialState => ProfileLoading();

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
    try {
      _postsSubscription?.cancel();
      _postsSubscription = _firestoreRepo.getUserPosts(userId).listen(
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
    // if (post.owner != user.id) {
    if (post.likes[user.id] == true) {
      await _firestoreRepo.addLikesToFeed(post, user);
    } else {
      await _firestoreRepo.removeLikesToFeed(post, user);
    }
    // }
  }

  @override
  Future<void> close() {
    _postsSubscription?.cancel();
    return super.close();
  }
}

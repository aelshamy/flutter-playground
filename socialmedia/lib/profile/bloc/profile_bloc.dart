import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:socialmedia/common/model/post.dart';
import 'package:socialmedia/common/model/user.dart';
import 'package:socialmedia/repo/firestore_repo.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final FirestoreRepo firestoreRepo;
  StreamSubscription _postsSubscription;

  ProfileBloc({@required this.firestoreRepo}) : assert(firestoreRepo != null);

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
      _postsSubscription = firestoreRepo.getUserPosts(userId).listen(
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
    await firestoreRepo.likePost(post, user);
    // if (post.owner != user.id) {
    if (post.likes[user.id] == true) {
      await firestoreRepo.addLikesToFeed(post, user);
    } else {
      await firestoreRepo.removeLikesToFeed(post, user);
    }
    // }
  }

  @override
  Future<void> close() {
    _postsSubscription?.cancel();
    return super.close();
  }
}

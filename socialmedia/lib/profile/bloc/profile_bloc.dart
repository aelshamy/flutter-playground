import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialmedia/common/model/post.dart';
import 'package:socialmedia/common/model/user.dart';
import 'package:socialmedia/repo/firestore_repo.dart';

import './bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final FirestoreRepo _firestoreRepo;

  ProfileBloc({FirestoreRepo firestoreRepo}) : _firestoreRepo = firestoreRepo ?? FirestoreRepo();

  @override
  ProfileState get initialState => ProfileInitial();

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is LoadPosts) {
      yield* _mapLoadPostsToState(event.userId);
    }
    if (event is LikePost) {
      yield* _mapLikePostToState(event.post, event.user);
    }
  }

  Stream<ProfileState> _mapLoadPostsToState(String userId) async* {
    yield ProfileLoading();
    try {
      final postsDocuments = await _firestoreRepo.getUserPosts(userId);

      final posts = await postsDocuments.documents.map((DocumentSnapshot doc) => Post.fromDocument(doc)).toList();

      yield ProfileLoaded(posts: posts);
    } catch (e) {
      yield ProfileLoadError(error: e.toString());
    }
  }

  Stream<ProfileState> _mapLikePostToState(Post post, User user) async* {
    await _firestoreRepo.likePost(post, user);
  }
}

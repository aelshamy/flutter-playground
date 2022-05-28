import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import 'post_service.dart';

enum NotifierState { initial, loading, loaded }

class PostChangeNotifier extends ChangeNotifier {
  final _postService = PostService();

  NotifierState _state = NotifierState.initial;
  NotifierState get state => _state;
  void _setState(NotifierState state) {
    _state = state;
    notifyListeners();
  }

  late final Either<Failure, Post> _post;
  Either<Failure, Post> get post => _post;
  void _setPost(Either<Failure, Post> post) {
    _post = post;
    notifyListeners();
  }

  late final Failure _failure;
  Failure get failure => _failure;

  void getOnePost() async {
    _setState(NotifierState.loading);
    await Task(() => _postService.getOnePost())
        .attempt()
        // .mapLeftToFailure()
        .map(
          // Grab only the *left* side of Either<Object, Post>
          (either) => either.leftMap((obj) {
            try {
              // Cast the Object into a Failure
              return obj as Failure;
            } catch (e) {
              // 'rethrow' the original exception
              throw obj;
            }
          }),
        )
        .run()
        .then((value) => _setPost(value));
    _setState(NotifierState.loaded);
  }
}

extension TaskX<T extends Either<Object, U>, U> on Task<T> {
  Task<Either<Failure, U>> mapLeftToFailure() {
    return map(
      (either) => either.leftMap((obj) {
        try {
          return obj as Failure;
        } catch (e) {
          throw obj;
        }
      }),
    );
  }
}

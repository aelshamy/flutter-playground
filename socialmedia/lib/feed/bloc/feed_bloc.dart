import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:socialmedia/common/model/feed.dart';
import 'package:socialmedia/repo/firestore_repo.dart';
import './bloc.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final FirestoreRepo _firestoreRepo;
  StreamSubscription _commentsSubscription;

  FeedBloc({FirestoreRepo firestoreRepo}) : _firestoreRepo = firestoreRepo ?? FirestoreRepo();

  @override
  FeedState get initialState => FeedInitialState();

  @override
  Stream<FeedState> mapEventToState(
    FeedEvent event,
  ) async* {
    if (event is LoadFeed) {
      yield* _mapLoadFeedsToState(event.userId);
    }
    if (event is FeedLoaded) {
      yield* _mapFeedLoadedToState(event.feeds);
    }
  }

  Stream<FeedState> _mapLoadFeedsToState(String userId) async* {
    try {
      _commentsSubscription?.cancel();
      _commentsSubscription = _firestoreRepo.getFeed(userId).listen(
            (feeds) => add(FeedLoaded(feeds: feeds)),
          );
    } catch (e) {
      yield FeedLoadError(error: e.toString());
    }
  }

  Stream<FeedState> _mapFeedLoadedToState(List<Feed> feeds) async* {
    yield FeedRecieved(feeds: feeds);
  }

  @override
  Future<void> close() {
    _commentsSubscription.cancel();
    return super.close();
  }
}

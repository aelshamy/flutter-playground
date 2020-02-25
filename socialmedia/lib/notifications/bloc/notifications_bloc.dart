import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:socialmedia/common/model/notification.dart';
import 'package:socialmedia/repo/firestore_repo.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final FirestoreRepo _firestoreRepo;
  StreamSubscription _commentsSubscription;

  NotificationsBloc({FirestoreRepo firestoreRepo})
      : _firestoreRepo = firestoreRepo ?? FirestoreRepo();

  @override
  NotificationsState get initialState => NotificationsInitial();

  @override
  Stream<NotificationsState> mapEventToState(
    NotificationsEvent event,
  ) async* {
    if (event is LoadNotifications) {
      yield* _mapLoadFeedsToState(event.userId);
    }
    if (event is NotificationsLoaded) {
      yield* _mapFeedLoadedToState(event.notifications);
    }

    if (event is NotificationsShowPost) {
      yield NotificationsGoToPost(notification: event.notification);
    }
  }

  Stream<NotificationsState> _mapLoadFeedsToState(String userId) async* {
    try {
      _commentsSubscription?.cancel();
      _commentsSubscription = _firestoreRepo.getFeed(userId).listen(
            (notifications) => add(NotificationsLoaded(notifications: notifications)),
          );
    } catch (e) {
      yield NotificationsLoadError(error: e.toString());
    }
  }

  Stream<NotificationsState> _mapFeedLoadedToState(List<Notification> feeds) async* {
    yield FeedRecieved(notifications: feeds);
  }

  @override
  Future<void> close() {
    _commentsSubscription.cancel();
    return super.close();
  }
}

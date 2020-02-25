import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:socialmedia/common/model/notification.dart';
import 'package:socialmedia/repo/firestore_repo.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final FirestoreRepo firestoreRepo;
  StreamSubscription _commentsSubscription;

  NotificationsBloc({@required this.firestoreRepo}) : assert(firestoreRepo != null);

  @override
  NotificationsState get initialState => NotificationsInitial();

  @override
  Stream<NotificationsState> mapEventToState(
    NotificationsEvent event,
  ) async* {
    if (event is LoadNotifications) {
      yield* _mapLoadNotificationsToState(event.userId);
    }
    if (event is NotificationsLoaded) {
      yield* _mapNotificationsLoadedToState(event.notifications);
    }

    if (event is NotificationsShowPost) {
      yield NotificationsGoToPost(notification: event.notification);
    }
  }

  Stream<NotificationsState> _mapLoadNotificationsToState(String userId) async* {
    try {
      _commentsSubscription?.cancel();
      _commentsSubscription = firestoreRepo.getFeed(userId).listen(
            (notifications) => add(NotificationsLoaded(notifications: notifications)),
          );
    } catch (e) {
      yield NotificationsLoadError(error: e.toString());
    }
  }

  Stream<NotificationsState> _mapNotificationsLoadedToState(
      List<Notification> notifications) async* {
    yield NotificationsRecieved(notifications: notifications);
  }

  @override
  Future<void> close() {
    _commentsSubscription.cancel();
    return super.close();
  }
}

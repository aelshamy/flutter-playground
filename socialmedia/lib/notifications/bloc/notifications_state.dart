part of 'notifications_bloc.dart';

abstract class NotificationsState extends Equatable {
  const NotificationsState();
}

class NotificationsInitial extends NotificationsState {
  @override
  List<Object> get props => [];
}

class FeedRecieved extends NotificationsState {
  final List<Notification> notifications;

  const FeedRecieved({this.notifications});

  @override
  List<Object> get props => [notifications];
}

class NotificationsLoadError extends NotificationsState {
  final String error;

  const NotificationsLoadError({this.error});
  @override
  List<Object> get props => [error];
}

class NotificationsGoToPost extends NotificationsState {
  final Notification notification;

  const NotificationsGoToPost({this.notification});
  @override
  List<Object> get props => [notification];
}

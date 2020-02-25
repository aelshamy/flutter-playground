part of 'notifications_bloc.dart';

abstract class NotificationsEvent extends Equatable {
  const NotificationsEvent();
}

class LoadNotifications extends NotificationsEvent {
  final String userId;

  const LoadNotifications({this.userId});

  @override
  List<Object> get props => [userId];
}

class NotificationsLoaded extends NotificationsEvent {
  final List<Notification> notifications;

  const NotificationsLoaded({this.notifications});

  @override
  List<Object> get props => [notifications];
}

class NotificationsShowPost extends NotificationsEvent {
  final Notification notification;

  const NotificationsShowPost({this.notification});

  @override
  List<Object> get props => [notification];
}

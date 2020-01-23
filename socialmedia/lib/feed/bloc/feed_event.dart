import 'package:equatable/equatable.dart';
import 'package:socialmedia/common/model/feed.dart';

abstract class FeedEvent extends Equatable {
  const FeedEvent();
}

class LoadFeed extends FeedEvent {
  final String userId;

  const LoadFeed({this.userId});

  @override
  // TODO: implement props
  List<Object> get props => [userId];
}

class FeedLoaded extends FeedEvent {
  final List<Feed> feeds;

  const FeedLoaded({this.feeds});

  @override
  List<Object> get props => [feeds];
}

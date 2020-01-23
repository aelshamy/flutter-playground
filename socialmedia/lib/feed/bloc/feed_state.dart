import 'package:equatable/equatable.dart';
import 'package:socialmedia/common/model/feed.dart';

abstract class FeedState extends Equatable {
  const FeedState();
}

class FeedInitialState extends FeedState {
  @override
  List<Object> get props => [];
}

class FeedRecieved extends FeedState {
  final List<Feed> feeds;

  const FeedRecieved({this.feeds});

  @override
  List<Object> get props => [feeds];
}

class FeedLoadError extends FeedState {
  final String error;

  const FeedLoadError({this.error});
  @override
  List<Object> get props => [error];
}

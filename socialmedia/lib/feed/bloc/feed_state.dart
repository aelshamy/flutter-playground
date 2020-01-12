import 'package:equatable/equatable.dart';

abstract class FeedState extends Equatable {
  const FeedState();
}

class InitialFeedState extends FeedState {
  @override
  List<Object> get props => [];
}

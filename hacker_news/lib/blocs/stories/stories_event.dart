part of 'stories_bloc.dart';

abstract class StoriesEvent extends Equatable {
  const StoriesEvent();
}

class LoadStories extends StoriesEvent {
  @override
  List<Object> get props => [];
}

class RefreshStories extends StoriesEvent {
  @override
  List<Object> get props => [];
}

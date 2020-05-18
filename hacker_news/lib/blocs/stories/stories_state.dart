part of 'stories_bloc.dart';

abstract class StoriesState extends Equatable {
  const StoriesState();
}

class StoriesInitial extends StoriesState {
  @override
  List<Object> get props => [];
}

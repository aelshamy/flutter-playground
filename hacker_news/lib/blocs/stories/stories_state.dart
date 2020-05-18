part of 'stories_bloc.dart';

class StoriesState extends Equatable {
  final bool loading;
  final List<int> data;
  final String error;

  const StoriesState({this.loading, this.data, this.error});

  @override
  List<Object> get props => [loading, data, error];
}

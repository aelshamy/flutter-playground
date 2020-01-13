import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class SearchLoading extends SearchEvent {
  @override
  List<Object> get props => [];
}

class SearchLoaded extends SearchEvent {
  @override
  List<Object> get props => [];
}

class SearchError extends SearchEvent {
  @override
  List<Object> get props => [];
}

class SearchEmpty extends SearchEvent {
  @override
  List<Object> get props => [];
}

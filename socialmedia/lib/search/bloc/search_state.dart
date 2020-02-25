part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();
}

class SearchInitial extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchLoading extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchLoaded extends SearchState {
  final List<User> users;

  const SearchLoaded({this.users});

  @override
  List<Object> get props => [users];
}

class SearchError extends SearchState {
  final String error;

  const SearchError({this.error});

  @override
  String toString() {
    return "Search Error{error: $error}";
  }

  @override
  List<Object> get props => [error];
}

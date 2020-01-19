import 'package:equatable/equatable.dart';
import 'package:socialmedia/model/user.dart';

abstract class SearchState extends Equatable {
  const SearchState([List props = const <dynamic>[]]);
}

class SearchInitial extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchLoading extends SearchState {
  @override
  String toString() {
    return "Search Loading";
  }

  @override
  List<Object> get props => [];
}

class SearchLoaded extends SearchState {
  final List<User> users;

  SearchLoaded({this.users}) : super(<dynamic>[users]);

  @override
  String toString() {
    return "Search Loaded";
  }

  @override
  List<Object> get props => [];
}

class SearchError extends SearchState {
  final String error;

  SearchError({this.error}) : super(<dynamic>[error]);

  @override
  String toString() {
    return "Search Error{error: $error}";
  }

  @override
  List<Object> get props => [];
}

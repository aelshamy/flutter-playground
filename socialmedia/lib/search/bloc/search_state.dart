import 'package:equatable/equatable.dart';

abstract class SearchState extends Equatable {
  const SearchState();
}

class InitialSearchState extends SearchState {
  @override
  List<Object> get props => [];
}

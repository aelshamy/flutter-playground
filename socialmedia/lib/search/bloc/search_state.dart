import 'package:equatable/equatable.dart';

abstract class SearchState extends Equatable {
  const SearchState([List props = const []]);
  @override
  List<Object> get props => this.props;
}

class InitialSearchState extends SearchState {
  @override
  List<Object> get props => [];
}

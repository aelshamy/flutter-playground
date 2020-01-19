import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent([List props = const <dynamic>[]]);
}

class SearchStarted extends SearchEvent {
  String query;

  SearchStarted(this.query) : super(<dynamic>[query]);

  @override
  String toString() => 'Search {term: $query}';

  @override
  List<Object> get props => [query];
}

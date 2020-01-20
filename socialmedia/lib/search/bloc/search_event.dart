import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class SearchStarted extends SearchEvent {
  final String query;

  const SearchStarted(this.query);

  @override
  String toString() => 'Search {term: $query}';

  @override
  List<Object> get props => [query];
}

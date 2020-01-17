import 'package:equatable/equatable.dart';

abstract class SearchState extends Equatable {
  final List _props;
  const SearchState([this._props]);
  @override
  List<Object> get props => this._props;
}

class InitialSearchState extends SearchState {
  @override
  List<Object> get props => [];
}

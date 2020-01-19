import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:socialmedia/model/user.dart';
import 'package:socialmedia/repo/user_repository.dart';

import './bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final UserRepository _userRepository;

  SearchBloc({UserRepository userRepository}) : _userRepository = userRepository ?? UserRepository();

  @override
  SearchState get initialState => SearchInitial();

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is SearchStarted) {
      yield* _mapSearchStartedToState(event.query);
    }
  }

  Stream<SearchState> _mapSearchStartedToState(String query) async* {
    yield SearchLoading();
    try {
      final usersDocuments = await _userRepository.SearchUsers(query);
      final users = usersDocuments.documents.map((doc) => User.fromDocument(doc)).toList();
      yield SearchLoaded(users: users);
    } catch (e) {
      yield SearchError(error: e.toString());
    }
  }
}

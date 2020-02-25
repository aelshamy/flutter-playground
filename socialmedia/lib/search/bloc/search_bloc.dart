import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:socialmedia/common/model/user.dart';
import 'package:socialmedia/repo/firestore_repo.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final FirestoreRepo fireStoreRepo;

  SearchBloc({@required this.fireStoreRepo}) : assert(fireStoreRepo != null);

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
      final usersDocuments = await fireStoreRepo.searchUsers(query);
      final users = usersDocuments.documents.map((doc) => User.fromDocument(doc)).toList();
      yield SearchLoaded(users: users);
    } catch (e) {
      yield SearchError(error: e.toString());
    }
  }
}

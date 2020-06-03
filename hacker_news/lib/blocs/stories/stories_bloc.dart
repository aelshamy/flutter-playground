import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../repository/repository.dart';

part 'stories_event.dart';
part 'stories_state.dart';

class StoriesBloc extends Bloc<StoriesEvent, StoriesState> {
  final Repository _repository;

  StoriesBloc({Repository repository}) : _repository = repository ?? Repository();

  @override
  StoriesState get initialState => StoriesState();

  // @override
  // Stream<Transition<StoriesEvent, StoriesState>> transformTransitions(
  //     Stream<Transition<StoriesEvent, StoriesState>> transitions) {
  //   return transitions.transform(_itemsTransformers());
  //   // return super.transformTransitions(newTransitions);
  // }

  //   Stream<Transition<StoriesEvent, StoriesState>> _itemsTransformers() {
  //   return ScanStreamTransformer((Map<int, Future<ItemModel>> cache, int id, index) {
  //     cache[id] = _repository.fetchItem(id);
  //     return cache;
  //   }, <int, Future<ItemModel>>{});
  // }

  @override
  Stream<StoriesState> mapEventToState(StoriesEvent event) async* {
    if (event is LoadStories) {
      yield* _mapLoadStoriesToState();
    } else if (event is RefreshStories) {
      yield* _mapRefreshStoriesToState();
    }
  }

  Stream<StoriesState> _mapLoadStoriesToState() async* {
    // yield StoriesState(loading: true);
    try {
      final ids = await _repository.fetchTopIds();
      // final futureList = ids.map((id) => _repository.fetchItem(id)).toList();
      yield StoriesState(data: ids);
    } catch (e) {
      print(e);
    }
  }

  Stream<StoriesState> _mapRefreshStoriesToState() async* {
    await _repository.clearCache();
    yield* _mapLoadStoriesToState();
  }
}

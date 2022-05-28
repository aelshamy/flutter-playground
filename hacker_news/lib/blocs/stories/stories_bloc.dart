import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../repository/repository.dart';

part 'stories_event.dart';
part 'stories_state.dart';

class StoriesBloc extends Bloc<StoriesEvent, StoriesState> {
  late final Repository _repository;
  StoriesBloc({Repository? repository})
      : _repository = repository ?? Repository(),
        super(StoriesState()) {
    on<LoadStories>((event, emit) async {
      await getStories(emit);
    });

    on<RefreshStories>((event, emit) async {
      await _repository.clearCache();
      await getStories(emit);
    });
  }

  Future<void> getStories(Emitter<StoriesState> emit) async {
    try {
      final ids = await _repository.fetchTopIds();

      emit(StoriesState(data: ids));
    } catch (e) {
      print(e);
    }
  }

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

}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'stories_event.dart';
part 'stories_state.dart';

class StoriesBloc extends Bloc<StoriesEvent, StoriesState> {
  @override
  StoriesState get initialState => StoriesInitial();

  @override
  Stream<StoriesState> mapEventToState(StoriesEvent event) async* {}
}

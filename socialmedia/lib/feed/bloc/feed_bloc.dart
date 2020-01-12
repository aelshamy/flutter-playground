import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  @override
  FeedState get initialState => InitialFeedState();

  @override
  Stream<FeedState> mapEventToState(
    FeedEvent event,
  ) async* {
    // TODO: Add Logic
  }
}

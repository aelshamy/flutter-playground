import 'dart:async';

import 'package:bloc/bloc.dart';

import './bloc.dart';

class TimelineBloc extends Bloc<TimelineEvent, TimelineState> {
  @override
  TimelineState get initialState => InitialTimelineState();

  @override
  Stream<TimelineState> mapEventToState(
    TimelineEvent event,
  ) async* {}
}

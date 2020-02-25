part of 'timeline_bloc.dart';

abstract class TimelineState extends Equatable {
  const TimelineState();
}

class InitialTimelineState extends TimelineState {
  @override
  List<Object> get props => [];
}

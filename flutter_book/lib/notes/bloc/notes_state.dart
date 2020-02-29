part of 'notes_bloc.dart';

abstract class NotesState extends Equatable {
  const NotesState();
}

class NotesInitial extends NotesState {
  @override
  List<Object> get props => [];
}

class NotesLoaded extends NotesState {
  final List<Note> notes;

  NotesLoaded({this.notes});

  @override
  List<Object> get props => [notes];
}

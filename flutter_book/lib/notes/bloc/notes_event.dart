part of 'notes_bloc.dart';

abstract class NotesEvent extends Equatable {
  const NotesEvent();
}

class NotesSetColor extends NotesEvent {
  final String color;

  NotesSetColor({this.color});

  @override
  List<Object> get props => [color];
}

class LoadNotes extends NotesEvent {
  @override
  List<Object> get props => [];
}

class DeleteNote extends NotesEvent {
  final int noteId;

  DeleteNote({this.noteId});

  @override
  List<Object> get props => [noteId];
}

class AddNote extends NotesEvent {
  final Note note;

  AddNote({this.note});

  @override
  List<Object> get props => [note];
}

class UpdateNote extends NotesEvent {
  final Note note;

  UpdateNote({this.note});

  @override
  List<Object> get props => [note];
}

part of 'notes_bloc.dart';

abstract class NotesEvent extends Equatable {
  const NotesEvent();
}

class NotesSetColor extends NotesEvent {
  final String color;

  const NotesSetColor({required this.color});

  @override
  List<Object> get props => [color];
}

class LoadNotes extends NotesEvent {
  @override
  List<Object> get props => [];
}

class DeleteNote extends NotesEvent {
  final int noteId;

  const DeleteNote({required this.noteId});

  @override
  List<Object> get props => [noteId];
}

class AddNote extends NotesEvent {
  final Note note;

  const AddNote({required this.note});

  @override
  List<Object> get props => [note];
}

class UpdateNote extends NotesEvent {
  final Note note;

  const UpdateNote({required this.note});

  @override
  List<Object> get props => [note];
}

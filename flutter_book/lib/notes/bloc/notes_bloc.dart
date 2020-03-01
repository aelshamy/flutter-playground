import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_book/notes/note.dart';
import 'package:flutter_book/notes/repo/notes_repo.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final NotesRepo _notesRepo;

  NotesBloc({NotesRepo notesRepo}) : _notesRepo = notesRepo ?? NotesRepo();

  @override
  NotesState get initialState => NotesInitial();

  @override
  Stream<NotesState> mapEventToState(
    NotesEvent event,
  ) async* {
    if (event is LoadNotes) {
      yield* _mapLoadNotesToState();
    }

    if (event is AddNote) {
      yield* _mapAddNoteToState(event.note);
    }
    if (event is UpdateNote) {
      yield* _mapUpdateNoteToState(event.note);
    }
    if (event is DeleteNote) {
      yield* _mapDeleteNoteToState(event.noteId);
    }
  }

  Stream<NotesState> _mapLoadNotesToState() async* {
    final notes = await _notesRepo.getAll();
    yield NotesLoaded(notes: notes);
  }

  Stream<NotesState> _mapAddNoteToState(Note note) async* {
    await _notesRepo.addNote(note);
    final notes = await _notesRepo.getAll();
    yield NotesLoaded(notes: notes);
  }

  Stream<NotesState> _mapUpdateNoteToState(Note note) async* {
    await _notesRepo.updateNote(note);
    final notes = await _notesRepo.getAll();
    yield NotesLoaded(notes: notes);
  }

  Stream<NotesState> _mapDeleteNoteToState(int noteId) async* {
    await _notesRepo.deleteNote(noteId);
    final notes = await _notesRepo.getAll();
    yield NotesLoaded(notes: notes);
  }
}

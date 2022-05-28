import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_book/notes/note.dart';
import 'package:flutter_book/notes/repo/notes_repo.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final NotesRepo _notesRepo;
  NotesBloc({NotesRepo? notesRepo})
      : _notesRepo = notesRepo ?? NotesRepo(),
        super(NotesInitial()) {
    on<LoadNotes>((event, emit) async {
      final notes = await _notesRepo.getAll();
      emit(NotesLoaded(notes: notes));
    });
    on<AddNote>((event, emit) async {
      await _notesRepo.addNote(event.note);
      final notes = await _notesRepo.getAll();
      emit(NotesLoaded(notes: notes));
    });
    on<UpdateNote>((event, emit) async {
      await _notesRepo.updateNote(event.note);
      final notes = await _notesRepo.getAll();
      emit(NotesLoaded(notes: notes));
    });
    on<DeleteNote>((event, emit) async {
      await _notesRepo.deleteNote(event.noteId);
      final notes = await _notesRepo.getAll();
      emit(NotesLoaded(notes: notes));
    });
  }
}

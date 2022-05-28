import 'package:flutter_book/notes/note.dart';
import 'package:flutter_book/notes/repo/notes_provider.dart';

class NotesRepo {
  final NotesProvider _notesProvider;
  NotesRepo({NotesProvider? notesProvider})
      : _notesProvider = notesProvider ?? NotesProvider();

  Future<List<Note>> getAll() {
    return _notesProvider.getAll();
  }

  Future<int> addNote(Note note) {
    return _notesProvider.create(note);
  }

  Future<int> updateNote(Note note) {
    return _notesProvider.update(note);
  }

  Future<int> deleteNote(int noteId) {
    return _notesProvider.delete(noteId);
  }
}

import 'package:flutter_book/notes/model/note.dart';
import 'package:flutter_book/utils.dart' as utils;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NotesProvider {
  Database _db;

  Future get database async {
    if (_db == null) {
      _db = await init();
    }
    return _db;
  }

  Future<Database> init() async {
    String path = join(utils.docsDir.path, "notes.db");
    Database db = await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database inDB, int inVersion) async {
      await inDB.execute("CREATE TABLE IF NOT EXISTS notes ("
          "id INTEGER PRIMARY KEY,"
          "title TEXT,"
          "content TEXT,"
          "color TEXT"
          ")");
    });
    return db;
  }

  Future<int> create(Note note) async {
    Database db = await database;
    var val = await db.rawQuery("SELECT MAX(id) + 1 AS id FROM notes");
    int id = val.first["id"];
    if (id == null) {
      id = 1;
    }
    return await db.rawInsert(
        "INSERT INTO notes (id, title, content, color) "
        "VALUES (?, ?, ?, ?)",
        [id, note.title, note.content, note.color]);
  }

  Future<Note> get(int inID) async {
    Database db = await database;
    var rec = await db.query("notes", where: "id = ?", whereArgs: [inID]);
    return Note.fromMap(rec.first);
  }

  Future<List<Note>> getAll() async {
    Database db = await database;
    List<Map<String, dynamic>> notes = await db.query("notes");
    List<Note> list = notes.isNotEmpty ? notes.map((m) => Note.fromMap(m)).toList() : [];
    return list;
  }

  Future<int> update(Note inNote) async {
    Database db = await database;
    return await db.update(
      "notes",
      inNote.toMap(inNote),
      where: "id = ?",
      whereArgs: [inNote.id],
    );
  }

  Future<int> delete(int noteId) async {
    Database db = await database;
    return await db.delete(
      "notes",
      where: "id = ?",
      whereArgs: [noteId],
    );
  }
}

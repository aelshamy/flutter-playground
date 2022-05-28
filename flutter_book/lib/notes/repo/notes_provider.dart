import 'package:flutter_book/config.dart';
import 'package:flutter_book/notes/note.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NotesProvider {
  late Database? _db;
  final String _tableName = "notes";

  Future get database async {
    _db ??= await init();
    return _db;
  }

  Future<Database> init() async {
    String path = join(AppConfig.docsDir.path, "$_tableName.db");
    Database db = await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database inDB, int inVersion) async {
      await inDB.execute("CREATE TABLE IF NOT EXISTS $_tableName ("
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
    final val = await db.rawQuery("SELECT MAX(id) + 1 AS id FROM $_tableName");
    int? id = val.first["id"] as int?;
    id ??= 1;
    return await db.rawInsert(
        "INSERT INTO $_tableName (id, title, content, color) "
        "VALUES (?, ?, ?, ?)",
        [id, note.title, note.content, note.color]);
  }

  Future<Note> get(int inID) async {
    Database db = await database;
    var rec = await db.query(_tableName, where: "id = ?", whereArgs: [inID]);
    return Note.fromMap(rec.first);
  }

  Future<List<Note>> getAll() async {
    Database db = await database;
    List<Map<String, dynamic>> notes = await db.query(_tableName);
    List<Note> list =
        notes.isNotEmpty ? notes.map((m) => Note.fromMap(m)).toList() : [];
    return list;
  }

  Future<int> update(Note inNote) async {
    Database db = await database;
    return await db.update(
      _tableName,
      inNote.toMap(inNote),
      where: "id = ?",
      whereArgs: [inNote.id],
    );
  }

  Future<int> delete(int noteId) async {
    Database db = await database;
    return await db.delete(
      _tableName,
      where: "id = ?",
      whereArgs: [noteId],
    );
  }
}

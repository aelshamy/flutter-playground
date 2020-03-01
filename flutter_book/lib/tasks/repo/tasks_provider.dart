import 'package:flutter_book/tasks/task.dart';
import 'package:flutter_book/utils.dart' as utils;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TasksProvider {
  Database _db;

  Future get database async {
    if (_db == null) {
      _db = await init();
    }
    return _db;
  }

  Future<Database> init() async {
    String path = join(utils.docsDir.path, "tasks.db");
    Database db = await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database inDB, int inVersion) async {
      await inDB.execute("CREATE TABLE IF NOT EXISTS tasks ("
          "id INTEGER PRIMARY KEY,"
          "description TEXT,"
          "dueDate TEXT,"
          "completed TEXT"
          ")");
    });
    return db;
  }

  Future<int> create(Task task) async {
    Database db = await database;
    var val = await db.rawQuery("SELECT MAX(id) + 1 AS id FROM tasks");
    int id = val.first["id"];
    if (id == null) {
      id = 1;
    }
    return await db.rawInsert(
        "INSERT INTO tasks (id, description, dueDate, completed) "
        "VALUES (?, ?, ?, ?)",
        [id, task.description, task.dueDate, task.completed]);
  }

  Future<Task> get(int taskId) async {
    Database db = await database;
    var rec = await db.query("tasks", where: "id = ?", whereArgs: [taskId]);
    return Task.fromMap(rec.first);
  }

  Future<List<Task>> getAll() async {
    Database db = await database;
    List<Map<String, dynamic>> tasks = await db.query("tasks");
    List<Task> list = tasks.isNotEmpty ? tasks.map((m) => Task.fromMap(m)).toList() : [];
    return list;
  }

  Future<int> update(Task task) async {
    Database db = await database;
    return await db.update(
      "tasks",
      task.toMap(task),
      where: "id = ?",
      whereArgs: [task.id],
    );
  }

  Future<int> delete(int taskId) async {
    Database db = await database;
    return await db.delete(
      "tasks",
      where: "id = ?",
      whereArgs: [taskId],
    );
  }
}

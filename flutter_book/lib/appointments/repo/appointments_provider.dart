import 'package:flutter_book/appointments/appointment.dart';
import 'package:flutter_book/config.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppointmentsProvider {
  Database _db;
  String _tableName = "appointments";

  Future get database async {
    if (_db == null) {
      _db = await init();
    }
    return _db;
  }

  Future<Database> init() async {
    String path = join(AppConfig.docsDir.path, "$_tableName.db");
    Database db = await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database inDB, int inVersion) async {
      await inDB.execute("CREATE TABLE IF NOT EXISTS $_tableName ("
          "id INTEGER PRIMARY KEY,"
          "title TEXT,"
          "description TEXT,"
          "appointmentDate TEXT,"
          "appointmentTime TEXT"
          ")");
    });
    return db;
  }

  Future<int> create(Appointment appointment) async {
    Database db = await database;
    var val = await db.rawQuery("SELECT MAX(id) + 1 AS id FROM $_tableName");
    int id = val.first["id"];
    if (id == null) {
      id = 1;
    }
    return await db.rawInsert(
      "INSERT INTO $_tableName (id, title, description, appointmentDate, appointmentTime) "
      "VALUES (?, ?, ?, ?, ?)",
      [
        id,
        appointment.title,
        appointment.description,
        appointment.appointmentDate,
        appointment.appointmentTime,
      ],
    );
  }

  Future<Appointment> get(int appointmentId) async {
    Database db = await database;
    var rec = await db.query(_tableName, where: "id = ?", whereArgs: [appointmentId]);
    return Appointment.fromMap(rec.first);
  }

  Future<List<Appointment>> getAll() async {
    Database db = await database;
    List<Map<String, dynamic>> appointments = await db.query(_tableName);
    List<Appointment> list =
        appointments.isNotEmpty ? appointments.map((m) => Appointment.fromMap(m)).toList() : [];
    return list;
  }

  Future<int> update(Appointment appointment) async {
    Database db = await database;

    return await db.update(
      _tableName,
      appointment.toMap(appointment),
      where: "id = ?",
      whereArgs: [appointment.id],
    );
  }

  Future<int> delete(int appointmentId) async {
    Database db = await database;
    return await db.delete(
      _tableName,
      where: "id = ?",
      whereArgs: [appointmentId],
    );
  }
}

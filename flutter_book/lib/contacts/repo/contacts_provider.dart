import 'package:flutter_book/config.dart';
import 'package:flutter_book/contacts/contact.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ContactsProvider {
  Database _db;
  String _tableName = "contacts";

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
          "name TEXT,"
          "email TEXT,"
          "phone TEXT,"
          "birthday TEXT"
          ")");
    });
    return db;
  }

  Future<int> create(Contact contact) async {
    Database db = await database;
    var val = await db.rawQuery("SELECT MAX(id) + 1 AS id FROM $_tableName");
    int id = val.first["id"];
    if (id == null) {
      id = 1;
    }
    return await db.rawInsert(
      "INSERT INTO $_tableName (id, name, email, phone, birthday) "
      "VALUES (?, ?, ?, ?, ?)",
      [
        id,
        contact.name,
        contact.email,
        contact.phone,
        contact.birthday,
      ],
    );
  }

  Future<Contact> get(int contactId) async {
    Database db = await database;
    var rec = await db.query(_tableName, where: "id = ?", whereArgs: [contactId]);
    return Contact.fromMap(rec.first);
  }

  Future<List<Contact>> getAll() async {
    Database db = await database;
    List<Map<String, dynamic>> contacts = await db.query(_tableName);
    List<Contact> list =
        contacts.isNotEmpty ? contacts.map((m) => Contact.fromMap(m)).toList() : [];
    return list;
  }

  Future<int> update(Contact contact) async {
    Database db = await database;

    return await db.update(
      _tableName,
      contact.toMap(contact),
      where: "id = ?",
      whereArgs: [contact.id],
    );
  }

  Future<int> delete(int contactId) async {
    Database db = await database;
    return await db.delete(
      _tableName,
      where: "id = ?",
      whereArgs: [contactId],
    );
  }
}

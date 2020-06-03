import 'dart:io';

import 'package:hacker_news/models/item_model.dart';
import 'package:hacker_news/repository/cache.dart';
import 'package:hacker_news/repository/source.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbProvider implements Source, Cache {
  Database db;
  final _dbName = "Items";

  static final DbProvider instance = DbProvider._internal();

  DbProvider._internal() {
    init();
  }

  init() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, "$_dbName.db");

    db = await openDatabase(path, version: 1, onCreate: (Database newDb, int version) {
      newDb.execute(""" 
        CREATE TABLE IF NOT EXISTS $_dbName
        (
          id INTEGER PRIMARY KEY,
          type TEXT,
          by TEXT,
          time INTEGER,
          text TEXT,
          parent INTEGER,
          kids BLOB,
          dead INTEGER,
          deleted INTEGER,
          url TEXT,
          score INTEGER,
          title TEXT,
          descendants INTEGER
        )
        """);
    });
  }

  @override
  Future<ItemModel> fetchItem(int id) async {
    final maps = await db.query(
      _dbName,
      columns: null,
      where: "id = ?",
      whereArgs: [id],
    );

    return maps.length > 0 ? ItemModel.fromDb(maps.first) : null;
  }

  @override
  Future<int> addItem(ItemModel item) {
    return db.insert(
      _dbName,
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  @override
  Future<List<int>> fetchTopIds() {
    return null;
  }

  @override
  Future<int> clear() {
    return db.delete(_dbName);
  }
}

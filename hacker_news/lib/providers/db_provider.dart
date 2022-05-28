import 'dart:async';
import 'dart:io';

import 'package:hacker_news/models/item_model.dart';
import 'package:hacker_news/repository/cache.dart';
import 'package:hacker_news/repository/source.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbProvider implements Source, Cache {
  static final _databaseName = "Items.db";
  static final _databaseVersion = 1;
  final _tableName = "items";

  DbProvider._privateConstructor();
  static final DbProvider instance = DbProvider._privateConstructor();

  static late Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  FutureOr<void> _onCreate(Database newDb, int version) async {
    await newDb.execute("""
        CREATE TABLE $_tableName
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
  }

  @override
  Future<ItemModel?> fetchItem(int id) async {
    final maps = await _database!.query(
      _tableName,
      columns: null,
      where: "id = ?",
      whereArgs: [id],
    );

    return maps.length > 0 ? ItemModel.fromDb(maps.first) : null;
  }

  @override
  Future<int> addItem(ItemModel item) {
    return _database!.insert(
      _tableName,
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  @override
  Future<List<int>> fetchTopIds() async {
    return [];
  }

  @override
  Future<int> clear() {
    return _database!.delete(_tableName);
  }
}

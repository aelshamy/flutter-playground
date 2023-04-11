import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:persisting_data/data/sembast_codec.dart';
import 'package:persisting_data/models/password.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class SembastDb {
  DatabaseFactory dbFactory = databaseFactoryIo;
  Database? _db;

  final store = intMapStoreFactory.store('passwords');
  var codec = getEncryptSembastCodec(password: 'Password');

  static final SembastDb _instance = SembastDb._internal();

  SembastDb._internal();

  factory SembastDb() => _instance;

  Future<Database> init() async {
    _db ??= await openDb();
    return _db!;
  }

  Future<Database> openDb() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final dbPath = join(docsDir.path, 'pass.db');
    final db = await dbFactory.openDatabase(dbPath, codec: codec);
    return db;
  }

  Future<int> addPassword(Password password) {
    return store.add(_db!, password.toMap());
  }

  Future<List<Password>> getPasswords() async {
    await init();
    final finder = Finder(sortOrders: [SortOrder('name')]);
    final snapshot = await store.find(_db!, finder: finder);
    final list = snapshot
        .map((item) => Password.fromMap(item.value).copyWith(id: item.key))
        .toList();
    return list;
  }

  Future<int> updatePassword(Password password) {
    final finder = Finder(filter: Filter.byKey(password.id));
    return store.update(_db!, password.toMap(), finder: finder);
  }

  Future<int> deletePassword(Password password) {
    final finder = Finder(filter: Filter.byKey(password.id));
    return store.delete(_db!, finder: finder);
  }

  Future<int> deleteAll() {
    return store.delete(_db!);
  }
}

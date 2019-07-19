import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB {

  Database _db;

  Future init() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'demo.db');

    _db = await openDatabase(path, version: 1, onCreate: (Database db, int version) async {

      await db.execute("CREATE TABLE IF NOT EXISTS TODO(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT)");
    });

    return _db;
  }

  Future<Database> getDB() async {
    if (_db == null) {
      await init();
    }

    return _db;
  }

  Future close() async {
    await _db.close();
  }

  Future insert(String title) async {
    return await _db.transaction((txn) async {
      txn.rawInsert("INSERT INTO TODO(title) VALUES(?)", [title]);
    });
  }

  Future<List> select() async {
    List todos = await _db.rawQuery("SELECT * FROM TODO");

    return todos;
  }

  Future<int> delete(int id) async {
    var result = await _db.rawDelete("DELETE FROM TODO WHERE id = ?", [id]);
    return result;
  }

  void drop() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'demo.db');
    deleteDatabase(path);
  }
}
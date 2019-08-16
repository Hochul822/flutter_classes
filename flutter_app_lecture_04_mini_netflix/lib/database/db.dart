import 'package:flutter_app_lecture_04/model/favorite.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  Database _db;

  Future open() async {
    if (_db == null) {
      await init();
    }

    return _db;
  }

  Future init() async {
    String dbPath = await getDatabasesPath();
    String dbName = 'favorite.db';
    String path = join(dbPath, dbName);
    String sql = 'CREATE TABLE FAVORITE(id INTEGER PRIMARY KEY, favorite INTEGER)';

    _db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(sql);
    });
  }

  Future<List<Favorite>> selectList() async {
    String sql = 'SELECT * FROM FAVORITE WHERE favorite = 1';
    List list = await _db.rawQuery(sql);

    List<Favorite> favor =  listToFavorite(list);
    return favor;
  }
  
  Future<Favorite> select(int id) async {
    String sql = 'SELECT * FROM FAVORITE WHERE id = ?';

    List<dynamic> list = await _db.rawQuery(sql, [id]);
    if (list.length > 0) {
      Map map = list[0];

      return  Favorite.fromMap(map);
    }

    return null;
  }

  Future<int> update(Favorite favorite) async {

    String sql = 'UPDATE FAVORITE SET favorite = ? WHERE id = ?';
    return await _db.rawUpdate(sql, [favorite.favorite, favorite.id]);
  }

  Future updateFavorite(Favorite favorite) async {
    String sql = 'SELECT * FROM FAVORITE WHERE id = ?';
    List result = await _db.rawQuery(sql, [favorite.id]);

    //  데이터가 없으면 insert , 있으면 업데이트
    if (result.length == 0) {
      await insert(favorite);
    } else {
      await update(favorite);
    }
  }

  Future insert(Favorite favorite) async {
    String sql = 'INSERT INTO FAVORITE(id,favorite) VALUES(?,?)';
    int result = -1;
    print(sql);

    await _db.transaction((tx) async {
      result = await tx.rawInsert(sql, [favorite.id, favorite.favorite]);
    });

    print(result);

    return result;
  }

  Future<int> delete(Favorite favorite) async {
    String sql = 'DELETE FROM FAVORITE WHERE id = ?';
    return await _db.rawDelete(sql, [favorite.id]);
  }

  Future close() async {
    _db.close();
  }

  Future drop() async {
    String dbPath = await getDatabasesPath();
    String dbName = 'favorite.db';
    String path = join(dbPath, dbName);
    await deleteDatabase(path);
  }
}
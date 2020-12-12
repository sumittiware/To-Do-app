import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:to_do/Models/task.dart';

class DataBase {
  static Future<sql.Database> getDatabase() async {
    final dbpath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbpath, 'tasks.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE tasksManager(id TEXT PRIMARY KEY,title TEXT,description TEXT,category TEXT,date TEXT,time TEXT,isUrgent INTEGER,isDone INTEGER)');
    }, version: 1);
  }

  static Future<void> insert(Task task) async {
    final db = await DataBase.getDatabase();
    await db.insert('tasksManager', task.toMap(task),
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    print('Transaction Data added');
  }

  static Future<List<Map<String, dynamic>>> fetch() async {
    final sqlDb = await DataBase.getDatabase();
    print('fetched and ready to return data');
    return sqlDb.query('tasksManager');
  }

  static Future<void> delete(String id) async {
    final sqlDb = await DataBase.getDatabase();
    await sqlDb.delete('tasksManager', where: "id=?", whereArgs: [id]);
    print('Item deleted from database');
  }
}

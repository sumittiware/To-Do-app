import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:to_do/Models/task.dart';

class DataBase {
  static Future<sql.Database> getDatabase() async {
    final dbpath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbpath, 'tasks.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE tasksManager(id INTEGER PRIMARY KEY,title TEXT,description TEXT,category TEXT,date TEXT,isDone INTEGER)');
    }, version: 1);
  }

  static Future<void> insert(Task task) async {
    final db = await DataBase.getDatabase();
    await db.insert('tasksManager', task.toMap(task),
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> fetch() async {
    final sqlDb = await DataBase.getDatabase();
    return sqlDb.query('tasksManager');
  }

  static Future<void> delete(int id) async {
    final sqlDb = await DataBase.getDatabase();
    await sqlDb.delete('tasksManager', where: "id=?", whereArgs: [id]);
  }

  static Future<void> update(int id, Task task) async {
    final sqlDb = await DataBase.getDatabase();
    await sqlDb.update('tasksManager', task.toMap(task),
        where: "id=?", whereArgs: [id]);
  }
}

import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/entities/task.dart';

class TaskDAO {
  static final TaskDAO instance = TaskDAO._init();
  static Database? _database;

  TaskDAO._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase('tasks.db');
    return _database!;
  }

  Future<Database> _initDatabase(String filepath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filepath);

    return await openDatabase(path, version: 1, onCreate: _onCreateDB);
  }

  Future<void> _onCreateDB(Database db, int version) async {
    await db.execute('''
    create table TASK
    (
      ID integer primary key autoincrement,
      NAME text not null,
      DESCRIPTION text,
      DUETIME text,
      STATUS text,
      IS_TRASHED boolean,
      TRASHED_TIME text
    )
    ''');
  }

  Future<void> createTask(Task task) async {
    final db = await instance.database;
    await db.insert('TASK', task.toJson());
  }

  Future<Task> readTaskById(int id) async {
    final db = await instance.database;
    final result = await db.query(
      'TASK',
      columns: [
        'ID',
        'NAME',
        'DESCRIPTION',
        'DUETIME',
        'STATUS',
        'IS_TRASHED',
        'TRASHED_TIME',
      ],
      where: 'ID = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return Task.fromJson(result.first);
    } else {
      throw Exception('Task ID $id Not Found');
    }
  }

  Future<List<Task>> readAllTasks() async {
    final db = await instance.database;
    final results = await db.query('TASK',
        columns: [
          'ID',
          'NAME',
          'DESCRIPTION',
          'DUETIME',
          'STATUS',
          'IS_TRASHED',
          'TRASHED_TIME',
        ],
        orderBy: 'DUETIME ASC');
    return results.map((result) => Task.fromJson(result)).toList();
  }

  Future<void> updateTask(Task task) async {
    final db = await instance.database;
    await db.update(
      'TASK',
      task.toJson(),
      where: 'ID = ?',
      whereArgs: [task.id],
    );
  }

  Future<void> deleteTaskById(int id) async {
    final db = await instance.database;
    await db.delete(
      'TASK',
      where: 'ID = ?',
      whereArgs: [id],
    );
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'models/taskCard.dart';

class DatabaseToDo {
  Future <Database> database() async{
    return openDatabase(
        join(await getDatabasesPath(), 'todo.db'),
    onCreate: (db, version) {
    // Run the CREATE TABLE statement on the database.
    return db.execute(
    'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, description TEXT)',
    );
    },
      version: 1,

    );
  }

  Future<void> insertTask(TaskCard task) async {
    Database _db = await database();
    await _db.insert("tasks", task.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<TaskCard>> getTasks() async {
    Database _db = await database();
    List<Map<String, dynamic>> taskMap = await _db.query('tasks');
    return List.generate(taskMap.length,(index){
      return TaskCard(taskMap[index]['id'],taskMap[index]['title'],taskMap[index]['description']);
    });
  }
}
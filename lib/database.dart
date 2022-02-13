
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/models/taskItem.dart';

import 'models/taskCard.dart';

class DatabaseToDo {
  Future<Database> database() async {
    String sqlCreate1 =  "CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, description TEXT)";
    String sqlCreate2 =  "CREATE TABLE todos(id INTEGER PRIMARY KEY, taskId INTEGER, title TEXT, isDone INTEGER)";

    return openDatabase(
      join(await getDatabasesPath(), 'todoDB.db'),
      onCreate: (db, version) async {
        await db.execute(sqlCreate1);
        await db.execute(sqlCreate2);
      },
      version: 1,
    )  ;
  }


  Future<int> insertTask(TaskCard task) async {
    int taskId = 0;
    Database _db = await database();
    await _db.insert(
        'tasks', task.toMap(), conflictAlgorithm: ConflictAlgorithm.replace)
        .then((value) {
      taskId = value;
    });
    return taskId;
  }

  Future<void> insertTaskItem(TaskItem taskItem) async {
    Database _db = await database();
    await _db.insert('todos', taskItem.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<TaskCard>> getTasks() async {
    Database _db = await database();
    List<Map<String, dynamic>> taskMap = await _db.query('tasks');
    return List.generate(taskMap.length, (index) {
      return TaskCard(id: taskMap[index]['id'],
          title: taskMap[index]['title'],
          description: taskMap[index]['description']);
    });
  }

  Future<List<TaskItem>> getTodos(int taskId) async {
    Database _db = await database();
    List<Map<String, dynamic>> todoMap = await _db.rawQuery('SELECT * FROM todos WHERE taskId = $taskId');
    return List.generate(todoMap.length, (index) {
      return TaskItem(id: todoMap[index]['id'],
          taskId:todoMap[index]['taskId'],
          title: todoMap[index]['title'],
          isDone: todoMap[index]['isDone']);
    });
  }

}


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:to_do/DataBase/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class Task with ChangeNotifier {
  final int id; //string INT
  final String title; //string TEXT
  final String description; //string TEXT
  final String category; //string TEXT
  final DateTime date; //string TEXT
  bool isDone; //integer INT
  Task(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.category,
      @required this.date,
      this.isDone = false});

  void toggleDone() async {
    isDone = !isDone;
    notifyListeners();
    try {
      await DataBase.update(this.id, this);
    } catch (e) {
      isDone = !isDone;
      notifyListeners();
    }
  }

  Map<String, dynamic> toMap(Task t) {
    return {
      'id': t.id,
      'title': t.title,
      'description': t.description,
      'category': t.category,
      'date': t.date.toIso8601String(),
      'isDone': (t.isDone) ? 1 : 0,
    };
  }
}

class TaskTodo with ChangeNotifier {
  int taskNumber;

  Future<void> fetchTaskNumber() async {
    final prefs = await SharedPreferences.getInstance();
    taskNumber = prefs.getInt('taskNumber');
  }

  Future<void> incrementTask() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('taskNumber', taskNumber + 1);
  }

  List<Task> _tasks = [];

  List<Task> get tasks {
    return [..._tasks];
  }

  List<Task> getByCategory(String type) {
    return _tasks.where((item) => item.category == type).toList();
  }

  Task findById(int id) {
    return _tasks.firstWhere((element) => element.id == id);
  }

  Future<void> fetchTasks() async {
    fetchTaskNumber();
    final fetchedData = await DataBase.fetch();
    try {
      _tasks = fetchedData
          .map((task) => Task(
              id: task['id'],
              title: task['title'],
              description: task['description'],
              category: task['category'],
              date: DateTime.parse(task['date']),
              isDone: task['isDone'] == 1))
          .toList();
    } catch (e) {
      throw (e);
    }
    notifyListeners();
  }

  void deleteTask(int id) async {
    _tasks.removeWhere((element) => element.id == id);
    DataBase.delete(id);
    await flutterLocalNotificationsPlugin.cancel(id); //to don't provide
    notifyListeners();
  }

  void addTask(Task t) {
    _tasks.add(t);
    DataBase.insert(t);
    incrementTask();
    print('task Added');
    notifyListeners();
  }
}

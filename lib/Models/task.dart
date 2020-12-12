import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:to_do/DataBase/database.dart';

class Time {
  final int hour;
  final int minute;
  Time(this.hour, this.minute);
  String toString() {
    return this.hour.toString() + ',' + this.minute.toString();
  }
}

class Task with ChangeNotifier {
  final String id; //string TEXT
  final String title; //string TEXT
  final String description; //string TEXT
  final String category; //string TEXT
  final DateTime date;
  final Time time; //string TEXT
  final bool isUrgent; //intrget INT
  bool isDone; //integer INT
  Task(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.category,
      @required this.date,
      @required this.time,
      @required this.isUrgent,
      this.isDone = false});

  void toggleDone() {
    isDone = !isDone;
    notifyListeners();
  }

  Map<String, dynamic> toMap(Task t) {
    return {
      'id': t.id,
      'title': t.title,
      'description': t.description,
      'category': t.category,
      'date': t.date.toIso8601String(),
      'time': t.time.toString(),
      'isUrgent': (t.isUrgent) ? 1 : 0,
      'isDone': (t.isDone) ? 1 : 0,
    };
  }
}

class TaskTodo with ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks {
    return [..._tasks];
  }

  List<Task> getByCategory(String type) {
    return _tasks.where((item) => item.category == type).toList();
  }

  List<Task> urgents() {
    return _tasks.where((item) => item.isUrgent == true).toList();
  }

  Task findById(String id) {
    return _tasks.firstWhere((element) => element.id == id);
  }

  Future<void> fetchTasks() async {
    final fetchedData = await DataBase.fetch();
    print(fetchedData);
    try {
      _tasks = fetchedData
          .map((task) => Task(
              id: task['id'],
              title: task['title'],
              description: task['description'],
              category: task['category'],
              date: DateTime.parse(task['date']),
              time: Time(int.parse(task['time'].split(",")[0]),
                  int.parse(task['time'].split(",")[1])),
              isUrgent: task['isUrgent'] == 1,
              isDone: task['isDone'] == 1))
          .toList();
    } catch (e) {
      print(e.toString());
    }

    print('>>>>tasks');
    print(_tasks);
    notifyListeners();
  }

  void deleteTask(String id) {
    _tasks.removeWhere((element) => element.id == id);
    DataBase.delete(id);
    notifyListeners();
  }

  void addTask(Task t) {
    _tasks.add(t);
    DataBase.insert(t);
    print('task Added');
    notifyListeners();
  }
}

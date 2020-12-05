import 'package:flutter/foundation.dart';
import 'package:to_do/Models/Enums.dart';

class Task with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final Tasktype category;
  final Importance importance;
  final DateTime date;
  bool isDone;
  Task(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.category,
      @required this.importance,
      @required this.date,
      this.isDone = false});

  void toggleDone() {
    isDone = !isDone;
    notifyListeners();
  }
}

class TaskTodo with ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks {
    return [..._tasks];
  }

  /*void deleteTask(String id) {
    _tasks.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void addTask(String id, String name, DateTime date) {
    _tasks.add(Task(id: id, title: name, date: date));
    notifyListeners();
  }*/
}

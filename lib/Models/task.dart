import 'package:flutter/foundation.dart';

class Task with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final String category;
  final DateTime date;
  final bool isUrgent;
  bool isDone;
  Task(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.category,
      @required this.date,
      @required this.isUrgent,
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

  List<Task> getByCategory(String type) {
    return _tasks.where((item) => item.category == type).toList();
  }

  Task findById(String id) {
    return _tasks.firstWhere((element) => element.id == id);
  }

  void deleteTask(String id) {
    _tasks.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void addTask(Task t) {
    _tasks.add(t);
    print('task Added');
    notifyListeners();
  }
}

import 'package:flutter/material.dart';

class AddTask extends StatefulWidget {
  static const routename = '/addtask';
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('add Task'),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Screens/Addtask.dart';
import 'package:to_do/Screens/taskpage.dart';
import './Screens/Homepage.dart';

void main() => runApp(Tasks());

class Tasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tasks',
      theme: ThemeData(
        primaryColor: Colors.amber[900],
        accentColor: Colors.amberAccent,
      ),
      home: Homepage(),
      routes: {
        Homepage.routename: (ctx) => Homepage(),
        TaskPage.routename: (ctx) => TaskPage(),
        AddTask.routename: (ctx) => AddTask()
      },
    );
  }
}

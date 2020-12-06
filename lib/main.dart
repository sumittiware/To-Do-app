import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Models/task.dart';
import 'package:to_do/Screens/Addtask.dart';
import 'package:to_do/Screens/taskpage.dart';
import './Screens/Homepage.dart';

void main() => runApp(Tasks());

class Tasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: TaskTodo())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tasks',
        theme: ThemeData(
          primaryColor: Color(0xFF584890),
          accentColor: Color(0xFFA090F0),
        ),
        home: Homepage(),
        routes: {
          Homepage.routename: (ctx) => Homepage(),
          TaskPage.routename: (ctx) => TaskPage(),
          AddTask.routename: (ctx) => AddTask()
        },
      ),
    );
  }
}

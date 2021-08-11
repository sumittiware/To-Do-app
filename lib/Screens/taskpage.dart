import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Config/config.dart';
import 'package:to_do/Models/task.dart';
import 'package:to_do/Widget/notask.dart';
import '../Widget/task.dart';
import '../Models/Tasktype.dart' as types;

class TaskPage extends StatelessWidget {
  static const routename = 'taskpage';
  @override
  Widget build(BuildContext context) {
    final typeId = ModalRoute.of(context).settings.arguments as String;
    final type = types
        .findById(typeId); //taking the provider to the whole required class
    final items = Provider.of<TaskTodo>(context).getByCategory(typeId);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
            height: height,
            width: width,
            child: Column(children: [
              Hero(
                tag: typeId,
                child: Material(
                  elevation: 10,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(height * 0.4)),
                  child: Container(
                      height: height * 0.1 + MediaQuery.of(context).padding.top,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: appbarGradient),
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(height * 0.4))),
                      child: Row(
                        children: [
                          IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 27,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              }),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            type.title,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 22),
                          ),
                        ],
                      )),
                ),
              ),
              Expanded(
                  child: (items.length == 0)
                      ? NoTask()
                      : SingleChildScrollView(
                          child: Column(
                            children: List.generate(items.length, (index) {
                              return TaskWidget(items[index].id);
                            }),
                          ),
                        ))
            ])));
  }
}

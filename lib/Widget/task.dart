import 'dart:math';

import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Models/task.dart';

class TaskWidget extends StatefulWidget {
  final String id;
  TaskWidget(this.id);
  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  bool _value = false;
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final task = Provider.of<TaskTodo>(context).findById(widget.id);
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 5, 5, 5),
      child: Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomRight:
                    (!_expanded) ? Radius.circular(30) : Radius.circular(0)),
            color: Color(0xFFA090F0)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircularCheckBox(
                    activeColor: Theme.of(context).primaryColor,
                    value: task.isDone,
                    onChanged: (value) {
                      setState(() {
                        task.toggleDone();
                      });
                    }),
                Container(
                  width: width * 0.5,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      task.title,
                      style: TextStyle(
                          fontSize: 20,
                          color: (task.isDone) ? Colors.red : Colors.white,
                          decoration: (task.isDone)
                              ? TextDecoration.lineThrough
                              : TextDecoration.none),
                    ),
                  ),
                ),
                IconButton(
                    icon: Icon(
                        (!_expanded) ? Icons.expand_more : Icons.expand_less),
                    onPressed: () {
                      setState(() {
                        _expanded = !_expanded;
                      });
                    })
              ],
            ),
            if (_expanded)
              Container(
                height: min(
                    double.parse(task.description.length.toString()) * 1 + 40,
                    200),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Date : ${DateFormat.yMd().format(task.date)}',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    Text(
                      'Description : ',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    if (task.description.length != 0)
                      Text(
                        task.description,
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      )
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}

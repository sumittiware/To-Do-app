import 'dart:math';

import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
    final tasks = Provider.of<TaskTodo>(context);
    final task = tasks.findById(widget.id);
    final label = (task.time.hour > 12) ? 'P.M.' : 'A.M.';
    final _showdata = (task.time.hour % 12).toString() +
        ':' +
        task.time.minute.toString() +
        label;
    final deleteT = tasks.deleteTask;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomLeft: (!_expanded) ? Radius.circular(30) : Radius.circular(0),
            bottomRight:
                (!_expanded) ? Radius.circular(30) : Radius.circular(0)),
        child: Container(
          padding: EdgeInsets.all(10),
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomLeft:
                      (!_expanded) ? Radius.circular(30) : Radius.circular(0),
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
                          if (_expanded) _expanded = false;
                          task.toggleDone();
                        });
                      }),
                  Container(
                    width: width * 0.5,
                    child: Text(
                      task.title,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          decoration: (task.isDone)
                              ? TextDecoration.lineThrough
                              : TextDecoration.none),
                    ),
                  ),
                  (task.isDone)
                      ? IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Theme.of(context).primaryColor,
                            size: 30,
                          ),
                          onPressed: () {
                            return showDialog(
                                context: context,
                                barrierDismissible: false,
                                child: AlertDialog(
                                  title: Text('Are you Sure?'),
                                  content: Text(
                                      'Do you really want to delete the task?'),
                                  actions: [
                                    FlatButton(
                                        color: Theme.of(context).primaryColor,
                                        onPressed: () {
                                          deleteT(task.id);
                                          Navigator.pop(context);
                                          Fluttertoast.showToast(
                                              msg: 'Task deleted',
                                              toastLength: Toast.LENGTH_LONG,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 4,
                                              backgroundColor:
                                                  Colors.grey.shade300,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                        },
                                        child: Text('Yes')),
                                    FlatButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('No'))
                                  ],
                                ));
                          })
                      : IconButton(
                          icon: Icon((!_expanded)
                              ? Icons.expand_more
                              : Icons.expand_less),
                          onPressed: () {
                            setState(() {
                              _expanded = !_expanded;
                            });
                          })
                ],
              ),
              if (_expanded && !task.isDone)
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                  height: min(
                      double.parse(task.description.length.toString()) * 1 +
                          100,
                      200),
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date : ${DateFormat.yMd().format(task.date)}',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Text('Time : ${_showdata}',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      Text(
                        'Description : ',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
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
      ),
    );
  }
}

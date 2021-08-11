import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Config/config.dart';
import 'package:to_do/Models/task.dart';

class TaskWidget extends StatefulWidget {
  final int id;
  TaskWidget(this.id);
  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget>
    with SingleTickerProviderStateMixin {
  bool _expanded = false;
  AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    //final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final tasks = Provider.of<TaskTodo>(context);
    final task = tasks.findById(widget.id);

    final deleteT = tasks.deleteTask;
    void taskDone() async {
      return showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: Text('Are you Sure?'),
              content: Text('Does the task is completed?'),
              actions: [
                FlatButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      task.toggleDone();
                      setState(() {
                        if (_expanded) _expanded = false;
                      });
                      Navigator.pop(context);
                    },
                    child: Text('Yes')),
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'No',
                      style: TextStyle(color: taskColor),
                    ))
              ],
            );
          });
    }

    void deleteTask() async {
      return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('Are you Sure?'),
            content: Text('Do you really want to delete the task?'),
            actions: [
              FlatButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () async {
                    deleteT(task.id);
                    Navigator.pop(context);
                    Fluttertoast.showToast(
                        msg: 'Task deleted',
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 4,
                        backgroundColor: Colors.grey.shade300,
                        fontSize: 16.0);
                  },
                  child: Text(
                    'Yes',
                    style: TextStyle(color: Colors.white),
                  )),
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'No',
                    style: TextStyle(color: taskColor),
                  ))
            ],
          );
        },
      );
    }

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
        child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            curve: Curves.fastOutSlowIn,
            height: _expanded ? 170 : 70,
            child: Container(
              padding: EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomLeft: (!_expanded)
                          ? Radius.circular(30)
                          : Radius.circular(0),
                      bottomRight: (!_expanded)
                          ? Radius.circular(30)
                          : Radius.circular(0)),
                  color: Theme.of(context).accentColor),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (!task.isDone)
                        Checkbox(
                            activeColor: buttonColor,
                            value: task.isDone,
                            onChanged: (_) {
                              taskDone();
                            }),
                      Container(
                        width: width * 0.5,
                        child: Text(
                          task.title,
                          style: TextStyle(
                              fontSize: 18,
                              color: (task.isDone) ? Colors.red : Colors.black,
                              decoration: (task.isDone)
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none),
                        ),
                      ),
                      (task.isDone)
                          ? IconButton(
                              icon: Icon(
                                Icons.delete,
                                size: 30,
                                color: buttonColor,
                              ),
                              onPressed: () {
                                deleteTask();
                              })
                          : IconButton(
                              icon: Icon((!_expanded)
                                  ? Icons.expand_more
                                  : Icons.expand_less),
                              onPressed: () {
                                if (_expanded) {
                                  setState(() {
                                    _expanded = false;
                                  });
                                  _controller.reverse();
                                } else {
                                  setState(() {
                                    _expanded = true;
                                  });
                                  _controller.forward();
                                }
                              })
                    ],
                  ),
                  if (_expanded && !task.isDone)
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(100),
                              bottomRight: Radius.circular(100))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Date : ${DateFormat.yMMMEd().format(task.date)}',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          if (task.description.length != 0)
                            Text(
                              task.description,
                              style: TextStyle(fontSize: 14),
                            )
                        ],
                      ),
                    )
                ],
              ),
            )),
      ),
    );
  }
}

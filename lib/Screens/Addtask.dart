import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Models/task.dart';
import 'package:to_do/Widget/selectttasktype.dart';

class AddTask extends StatefulWidget {
  static const routename = '/addtask';
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  String _title;
  String _description;
  DateTime _date;
  bool _isUrgent = false;
  String _type;
  final _form = GlobalKey<FormState>();

  void _chooseDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime(2021))
        .then((_pickeddate) {
      if (_pickeddate == null) {
        return;
      }
      setState(() {
        _date = _pickeddate;
      });
    });
  }

  void _selectType(String id) {
    _type = id;
  }

  void _submit() {
    FocusScope.of(context).unfocus();

    if (_title.isEmpty ||
        _description.isEmpty ||
        _type.isEmpty ||
        _date == null) {
      return;
    }
    final newTask = Task(
        id: DateTime.now().toString(),
        title: _title,
        description: _description,
        category: _type,
        date: _date,
        isUrgent: _isUrgent);
    //add to tasks
    try {
      Provider.of<TaskTodo>(context, listen: false).addTask(newTask);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
      height: height,
      width: width,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: height * 0.15 + MediaQuery.of(context).padding.top,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color(0xFF584890),
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(height * 0.4))),
                child: Row(
                  children: [
                    IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Add task',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                  ],
                )),
            Container(
              height: height * 0.85,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Form(
                key: _form,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: height * 0.05,
                    ),
                    TextFormField(
                      maxLength: 15,
                      maxLines: 1,
                      decoration: InputDecoration(
                        labelText: 'Title',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter title of the task';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _title = value;
                      },
                    ),
                    TextFormField(
                      maxLines: 2,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      onChanged: (value) {
                        _description = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter title of the task';
                        }
                        return null;
                      },
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(_date == null
                                ? 'No. Date chossen'
                                : 'Picked Date : ${DateFormat.yMd().format(_date)}'),
                          ),
                          FlatButton(
                            child: Text(
                              'Choose Date',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor),
                            ),
                            onPressed: _chooseDate,
                          ),
                        ],
                      ),
                    ),
                    SwitchListTile(
                      value: _isUrgent,
                      onChanged: (value) {
                        setState(() {
                          _isUrgent = value;
                        });
                      },
                      title: Text('Is the this task very urgent/important?'),
                    ),
                    SelectType(_selectType),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: height * 0.1,
                        width: width * 0.5,
                        child: RaisedButton.icon(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)),
                            color: Theme.of(context).primaryColor,
                            onPressed: () {
                              _submit();
                            },
                            icon: Icon(
                              Icons.book,
                              color: Colors.white,
                              size: 20,
                            ),
                            label: Text(
                              'Sumbit',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            )),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

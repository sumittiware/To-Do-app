import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  String _title = '';
  String _description = '';
  DateTime _date;
  TimeOfDay _time;
  String _showtime;
  bool _isUrgent = false;
  String _type = '';
  final _form = GlobalKey<FormState>();

  void _chooseDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
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

  void _chooseTime() {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((_pickedTime) {
      if (_pickedTime == null) {
        return;
      }
      setState(() {
        _time = _pickedTime;

        var label = (_time.hour > 12) ? 'P.M.' : 'A.M.';
        _showtime = (_time.hour % 12).toString() +
            ':' +
            _time.minute.toString() +
            label;
      });
    });
  }

  void _selectType(String id) {
    _type = id;
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    final _isValid = _form.currentState.validate();

    if (!_isValid || _type == null || _date == null) {
      Fluttertoast.showToast(
          msg: 'Please fill the respective fields',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 4,
          backgroundColor: Colors.grey.shade300,
          textColor: Colors.black,
          fontSize: 16.0);
      return;
    }
    final newTask = Task(
        id: DateTime.now().toString(),
        title: _title,
        description: _description,
        category: _type,
        date: _date,
        time: Time(_time.hour, _time.minute),
        isUrgent: _isUrgent);
    //add to tasks
    try {
      Provider.of<TaskTodo>(context, listen: false).addTask(newTask);
      Navigator.of(context).pop();
      Fluttertoast.showToast(
          msg: 'Task added',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 4,
          backgroundColor: Colors.grey.shade300,
          textColor: Colors.black,
          fontSize: 16.0);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Material(
              elevation: 10,
              borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(height * 0.4)),
              child: Container(
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
                        width: width * 0.05,
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
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Form(
                key: _form,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: height * 0.03,
                    ),
                    TextFormField(
                      maxLength: 20,
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
                      maxLength: 50,
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
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: Theme.of(context).primaryColor)),
                      child: Text(
                        'Select Task Deadline',
                        style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: Theme.of(context).primaryColor)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              _date == null
                                  ? 'No. Date chosen'
                                  : 'Picked Date : ${DateFormat.yMd().format(_date)}',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          FlatButton(
                            child: Text(
                              'Choose Date',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor),
                            ),
                            onPressed: _chooseDate,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: Theme.of(context).primaryColor)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              _time == null
                                  ? 'No. Time chosen'
                                  : 'Picked Time : ' + _showtime,
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          FlatButton(
                            child: Text(
                              'Choose Time',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor),
                            ),
                            onPressed: _chooseTime,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    SelectType(_selectType),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
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
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              )),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

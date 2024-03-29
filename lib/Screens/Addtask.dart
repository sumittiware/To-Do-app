import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Config/config.dart';
import 'package:to_do/Models/task.dart';
import 'package:to_do/Widget/selectttasktype.dart';
import 'package:to_do/main.dart';

class AddTask extends StatefulWidget {
  static const routename = '/addtask';
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  String _title = '';
  String _description = '';
  DateTime _date;
  String _type = '';
  final _form = GlobalKey<FormState>();
  bool _notify = false;

  int generateID() {
    final time = DateTime.now();
    final id = time.year.toString().substring(2) +
        time.month.toString() +
        time.day.toString() +
        time.hour.toString() +
        time.second.toString();
    return int.parse(id);
  }

  void _chooseDate(BuildContext ctx) {
    showDatePicker(
            builder: (BuildContext context, Widget child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  colorScheme: ColorScheme.light().copyWith(
                    primary: taskColor,
                  ),
                ),
                child: child,
              );
            },
            context: ctx,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2022))
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
    final _isValid = _form.currentState.validate();

    if (!_isValid) {
      Fluttertoast.showToast(
          msg: 'Please fill the respective fields',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 4,
          backgroundColor: Colors.grey.shade300,
          textColor: Colors.black,
          fontSize: 16.0);
      return;
    } else if (_date == null) {
      Fluttertoast.showToast(
          msg: 'Please select date',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 4,
          backgroundColor: Colors.grey.shade300,
          textColor: Colors.black,
          fontSize: 16.0);
      return;
    } else if (_type.isEmpty) {
      Fluttertoast.showToast(
          msg: 'Please select category',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 4,
          backgroundColor: Colors.grey.shade300,
          textColor: Colors.black,
          fontSize: 16.0);
      return;
    }
    final _id = generateID();
    final newTask = Task(
      id: _id,
      title: _title,
      description: _description,
      category: _type,
      date: _date,
    );
    //add to tasks
    try {
      Provider.of<TaskTodo>(context, listen: false).addTask(newTask);
      if (_notify) {
        scheduleTask(_id);
      }

      Navigator.of(context).pop();
      Fluttertoast.showToast(
          msg: (_notify) ? 'Task added & scheduled' : 'Task added',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 4,
          backgroundColor: Colors.grey.shade300,
          textColor: Colors.black,
          fontSize: 16.0);
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Error! Unable to add task',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 4,
          backgroundColor: Colors.grey.shade300,
          textColor: Colors.black,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    //final newID = Provider.of<TaskTodo>(context).taskNumber;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Material(
              elevation: 10,
              borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(height * 0.4)),
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
                            fontSize: 20),
                      ),
                    ],
                  )),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
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
                              borderRadius: BorderRadius.circular(20),
                            ),
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
                                borderRadius: BorderRadius.circular(20)),
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
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            'Select Task Deadline',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: 8, right: 8, bottom: 4, top: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  _date == null
                                      ? 'No Date selected'
                                      : '${DateFormat.yMMMd().format(_date)}',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              FlatButton(
                                child: Text(
                                  'Select Date',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor),
                                ),
                                onPressed: () => _chooseDate(context),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Notify me",
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  Text('Notify me on scheduled date'),
                                ],
                              ),
                              Switch(
                                  value: _notify,
                                  onChanged: (value) {
                                    setState(() {
                                      value = !_notify;
                                      _notify = !_notify;
                                    });
                                  })
                            ],
                          ),
                        ),
                        // SizedBox(
                        //   height: height * 0.01,
                        // ),
                        SelectType(_selectType),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              height: 60,
                              width: 170,
                              child: RaisedButton.icon(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  color: buttonColor,
                                  onPressed: () {
                                    _submit();
                                  },
                                  icon: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                  label: Text(
                                    'Add Task',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  )),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void scheduleTask(int id) async {
    try {
      var scheduleNotificationDatetime = _date;

      var androidChannelSpeciifics = AndroidNotificationDetails(
        'channelId',
        'channelName',
        'channelDescription',
        icon: '@mipmap/ic_launcher',
        ongoing: true,
      );
      var platformSpecifics =
          NotificationDetails(android: androidChannelSpeciifics);
      await flutterLocalNotificationsPlugin.schedule(id, _title, _description,
          scheduleNotificationDatetime, platformSpecifics);
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Error! Unable to schedule task',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 4,
          backgroundColor: Colors.grey.shade300,
          textColor: Colors.black,
          fontSize: 16.0);
    }
  }
}

import 'dart:async';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Models/task.dart';
import 'package:to_do/Screens/Addtask.dart';

import 'package:to_do/Widget/TaskTypewidget.dart';
import '../Models/Tasktype.dart' as t;

class Homepage extends StatefulWidget {
  static const routename = '/homepage';
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  AsyncMemoizer _memoizer;

  @override
  void initState() {
    super.initState();
    _memoizer = AsyncMemoizer();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: height,
            width: width,
            child: Column(
              children: [
                Material(
                  elevation: 10,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(height * 0.4)),
                  child: Container(
                      padding: EdgeInsets.all(20),
                      height:
                          height * 0.15 + MediaQuery.of(context).padding.top,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Color(0xFF584890),
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(height * 0.4))),
                      child: Row(
                        children: [
                          PopupMenuButton(
                            icon: Icon(
                              Icons.menu,
                              color: Colors.white,
                              size: 30,
                            ),
                            itemBuilder: (_) => [
                              PopupMenuItem(
                                child: Text('Share app'),
                                value: '#2',
                              ),
                              PopupMenuItem(
                                child: Text('About Us'),
                                value: '#3',
                              ),
                              PopupMenuItem(
                                child: Text('Rate us'),
                                value: '#4',
                              )
                            ],
                            onSelected: (value) {
                              print('Something else');
                            },
                          ),
                          SizedBox(
                            width: width * 0.1,
                          ),
                          Text(
                            'Task Master',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                        ],
                      )),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: height * 0.8,
                  child: FutureBuilder(
                      future: _fetchData(),
                      builder: (ctx, snapshot) {
                        return (snapshot.connectionState ==
                                ConnectionState.waiting)
                            ? Center(child: CircularProgressIndicator())
                            : GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: width * 0.5,
                                        mainAxisSpacing: 10,
                                        childAspectRatio: 1 / 1.2,
                                        crossAxisSpacing: 20),
                                itemBuilder: (ctx, index) => TasType(
                                    t.type[index].id,
                                    t.type[index].title,
                                    t.type[index].imagepath,
                                    t.type[index].color),
                                itemCount: t.type.length,
                              );
                      }),
                ),
              ],
            ),
          ),
          Positioned(
            child: SizedBox(
              width: width * 0.5,
              height: height * 0.1 + MediaQuery.of(context).padding.bottom,
              child: RaisedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushNamed(AddTask.routename);
                },
                icon: Icon(
                  Icons.add,
                  size: 30,
                  color: Colors.white,
                ),
                label: Text(
                  'Add Task',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                color: Color(0xFF584890),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(height * 0.1),
                        bottomLeft: Radius.circular(height * 0.1))),
              ),
            ),
            bottom: 5,
            right: 0,
          ),
        ],
      ),
    );
  }

  _fetchData() async {
    return _memoizer.runOnce(() async {
      return await Provider.of<TaskTodo>(context).fetchTasks();
    });
  }
}

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Config/config.dart';
import 'package:to_do/Models/task.dart';
import 'package:to_do/Screens/Addtask.dart';
import 'package:to_do/Widget/TaskTypewidget.dart';
import 'package:to_do/Widget/appbar.dart';

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
              child: Container(
                padding: EdgeInsets.fromLTRB(
                    20, 100 + MediaQuery.of(context).padding.top, 20, 0),
                height: height,
                child: FutureBuilder(
                    future: _fetchData(),
                    builder: (ctx, snapshot) {
                      return (snapshot.connectionState ==
                              ConnectionState.waiting)
                          ? Center(child: CircularProgressIndicator())
                          : (snapshot.hasError)
                              ? Center(
                                  child: Text('Something went wrong!!'),
                                )
                              : GridView(
                                  physics: BouncingScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: width * 0.5,
                                          mainAxisSpacing: 10,
                                          childAspectRatio: 1 / 1.2,
                                          crossAxisSpacing: 20),
                                  children: List.generate(
                                    t.type.length,
                                    (index) => TasType(
                                        t.type[index].id,
                                        t.type[index].title,
                                        t.type[index].imagepath,
                                        t.type[index].color),
                                  ),
                                );
                    }),
              )),
          Positioned(top: 0, child: CustomAppBar()),
          Positioned(
            child: SizedBox(
              width: width * 0.4,
              height: 60,
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
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                color: buttonColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
            ),
            bottom: height * 0.03,
            right: width * 0.03,
          ),
        ],
      ),
    );
  }

  //function to make the futureBuilder to run only once after the app is launched
  _fetchData() async {
    return _memoizer.runOnce(() async {
      return await Provider.of<TaskTodo>(context).fetchTasks();
    });
  }
}

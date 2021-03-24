import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Config/config.dart';
import 'package:to_do/Models/task.dart';
import 'package:to_do/Screens/Addtask.dart';
import 'package:to_do/Widget/TaskTypewidget.dart';
import 'package:to_do/Widget/bottomsheet.dart';
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

    void _moreMenu(BuildContext ctx) {
      showModalBottomSheet(
          context: ctx,
          builder: (_) {
            return MyBottomSheet();
          });
    }

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
                          gradient: LinearGradient(colors: appbarGradient),
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(height * 0.4))),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.menu,
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: () {
                              _moreMenu(context);
                            },
                          ),
                          SizedBox(
                            width: width * 0.1,
                          ),
                          Text(
                            'To-Do',
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
                            : (snapshot.hasError)
                                ? Center(
                                    child: Text('Something went wrong!!'),
                                  )
                                : GridView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
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
              height: height * 0.08 + MediaQuery.of(context).padding.bottom,
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
                color: buttonColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(height * 0.1)),
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

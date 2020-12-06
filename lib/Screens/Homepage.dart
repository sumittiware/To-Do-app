import 'package:flutter/material.dart';
import 'package:to_do/Screens/Addtask.dart';
import 'package:to_do/Widget/TaskTypewidget.dart';
import 'package:to_do/Widget/drawer.dart';
import '../Models/Tasktype.dart' as t;

class Homepage extends StatefulWidget {
  static const routename = '/homepage';
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool _drawerOpen = false;
  void _setDrawer() {
    setState(() {
      _drawerOpen = !_drawerOpen;
    });
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
                              Icons.menu,
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: () {
                              setState(() {
                                _drawerOpen = true;
                              });
                            }),
                        SizedBox(
                          width: 20,
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
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: height * 0.8,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
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
                  ),
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
                        topLeft: Radius.circular(30),
                        bottomLeft: Radius.circular(30))),
              ),
            ),
            bottom: 5,
            right: 0,
          ),
          if (_drawerOpen) MyDrawer(_setDrawer)
        ],
      ),
    );
  }
}

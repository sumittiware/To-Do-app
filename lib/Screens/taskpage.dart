import 'package:flutter/material.dart';
import '../Widget/task.dart';

class TaskPage extends StatelessWidget {
  static const routename = 'taskpage';
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
            height: height,
            width: width,
            child: Column(children: [
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
                            Navigator.pop(context);
                          }),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Category Name',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    ],
                  )),
              Container(
                height: height * 0.8,
                child: ListView.builder(
                  itemBuilder: (ctx, index) => TaskWidget(),
                  itemCount: 10,
                ),
              )
            ])));
  }
}

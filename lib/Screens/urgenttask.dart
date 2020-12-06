import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Models/task.dart';
import 'package:to_do/Widget/notask.dart';
import 'package:to_do/Widget/task.dart';

class UrgentTasksPage extends StatelessWidget {
  static const routename = '/urgenttasks';
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final urgents = Provider.of<TaskTodo>(context).urgents();
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
                      Container(
                        width: width * 0.7,
                        child: FittedBox(
                          child: Text(
                            'Urgent/Important Tasks',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                        ),
                      ),
                    ],
                  )),
              Container(
                height: height * 0.8,
                child: (urgents.length == 0)
                    ? NoTask()
                    : ListView.builder(
                        itemBuilder: (ctx, index) =>
                            TaskWidget(urgents[index].id),
                        itemCount: urgents.length,
                      ),
              )
            ])));
  }
}

import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';

class TaskWidget extends StatefulWidget {
  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  bool _value = false;
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 5, 5, 5),
      child: Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomRight:
                    (!_expanded) ? Radius.circular(30) : Radius.circular(0)),
            color: Color(0xFFA090F0)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircularCheckBox(
                    activeColor: Colors.green.shade200,
                    value: _value,
                    onChanged: (value) {
                      setState(() {
                        _value = value;
                      });
                    }),
                Text(
                  'Taskname',
                  style: TextStyle(
                      fontSize: 20,
                      decoration: (_value)
                          ? TextDecoration.lineThrough
                          : TextDecoration.none),
                ),
                IconButton(
                    icon: Icon(
                        (!_expanded) ? Icons.expand_more : Icons.expand_less),
                    onPressed: () {
                      setState(() {
                        _expanded = !_expanded;
                      });
                    })
              ],
            ),
            if (_expanded)
              Container(
                height: 100,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Date : DD/MM/YYYY',
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      'Description : ',
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                        'uvnu8apewuaip8ewasdifawnu8ta0ewvit7y4nq8pvarnuisnvsggigtjvgsgfopshotsnuedk')
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}

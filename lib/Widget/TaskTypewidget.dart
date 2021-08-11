import 'package:flutter/material.dart';
import 'package:to_do/Screens/taskpage.dart';

class TasType extends StatefulWidget {
  final String id;
  final String title;
  final String imagepath;
  final Color color;
  TasType(this.id, this.title, this.imagepath, this.color);
  @override
  _TasTypeState createState() => _TasTypeState();
}

class _TasTypeState extends State<TasType> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Hero(
      tag: widget.id,
      child: Material(
        child: Container(
          height: height * 0.4,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: LinearGradient(
                  colors: [widget.color.withOpacity(0.3), widget.color],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight)),
          child: InkWell(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(TaskPage.routename, arguments: widget.id);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  widget.imagepath,
                  fit: BoxFit.cover,
                  height: 100,
                  width: 100,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  widget.title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class NoTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Center(
      child: Text(
        'No Tasks added!!!',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}

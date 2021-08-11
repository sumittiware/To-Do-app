import 'package:flutter/material.dart';

class NoTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/nodata.png',
            height: 200,
            width: 200,
            fit: BoxFit.cover,
            semanticLabel: '',
          ),
          Text(
            "No Tasks added!!",
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class NoTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.4,
      width: width * 0.6,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/emptypage.jpg'),
              fit: BoxFit.cover)),
      child: Align(
          alignment: Alignment.bottomCenter, child: Text('No Task Added!!!')),
    );
  }
}

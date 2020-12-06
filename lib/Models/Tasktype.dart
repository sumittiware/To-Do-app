import 'dart:ui';

import 'package:flutter/material.dart';

class Tasktype {
  final String id;
  final String title;
  final String imagepath;
  final Color color;

  Tasktype(this.id, this.title, this.imagepath, this.color);
}

List<Tasktype> type = [
  Tasktype('T1', 'Work', 'assets/images/work.png', Colors.orange),
  Tasktype('T2', 'Study', 'assets/images/study.png', Colors.pink),
  Tasktype('T3', 'Home', 'assets/images/home.png', Colors.green),
  Tasktype('T4', 'Social', 'assets/images/social.png', Colors.blue),
  Tasktype('T5', 'Other', 'assets/images/others.png', Colors.brown)
];

Tasktype findById(String id) {
  return type.firstWhere((element) => element.id == id);
}

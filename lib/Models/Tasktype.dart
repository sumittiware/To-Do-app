import 'dart:ui';

import 'package:flutter/material.dart';

class Tasktype {
  final String title;
  final String imagepath;
  final Color color;

  Tasktype(this.title, this.imagepath, this.color);
}

List<Tasktype> type = [
  Tasktype('Work', 'assets/images/work.png', Colors.orange),
  Tasktype('Study', 'assets/images/study.png', Colors.pink),
  Tasktype('Home', 'assets/images/home.png', Colors.green),
  Tasktype('Social', 'assets/images/social.png', Colors.blue)
];

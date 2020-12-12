import 'dart:core';
import 'package:flutter/material.dart';
import '../Models/Tasktype.dart' as t;

class SelectType extends StatefulWidget {
  final Function selectType;
  SelectType(this.selectType);
  @override
  _SelectTypeState createState() => _SelectTypeState();
}

class _SelectTypeState extends State<SelectType> {
  bool _isSelected = false;
  String _selectedId;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Theme.of(context).primaryColor)),
            child: Text(
              'Select task category : ',
              style: TextStyle(
                  fontSize: 17, color: Theme.of(context).primaryColor),
              textAlign: TextAlign.end,
            ),
          ),
          Stack(
            children: [
              Container(
                child: Wrap(
                  children: [
                    buildCategoryContainer(
                        t.type[0].id, t.type[0].title, t.type[0].color),
                    buildCategoryContainer(
                        t.type[1].id, t.type[1].title, t.type[1].color),
                    buildCategoryContainer(
                        t.type[2].id, t.type[2].title, t.type[2].color),
                    buildCategoryContainer(
                        t.type[3].id, t.type[3].title, t.type[3].color),
                    buildCategoryContainer(
                        t.type[4].id, t.type[4].title, t.type[4].color)
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildCategoryContainer(String id, String title, Color color) {
    return InkWell(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
          _selectedId = id;
          if (_isSelected) {
            widget.selectType(id);
          } else {
            widget.selectType('');
          }
        });
      },
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: color.withOpacity(0.7)),
            child: Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white),
            ),
          ),
          if (_isSelected && _selectedId == id)
            Container(
              child: Icon(
                Icons.done,
                color: Colors.white,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.transparent.withOpacity(0.7)),
            )
        ],
      ),
    );
  }
}

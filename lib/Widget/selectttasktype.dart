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
            padding: EdgeInsets.only(top: 8, left: 0, right: 0, bottom: 8),
            child: Text(
              'Select task category : ',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Theme.of(context).primaryColor),
              textAlign: TextAlign.end,
            ),
          ),
          Stack(
            children: [
              Container(
                child: Wrap(
                    children: List.generate(
                        t.type.length,
                        (index) => buildCategoryContainer(t.type[index].id,
                            t.type[index].title, t.type[index].color))),
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
            widget.selectType(_selectedId);
          }
        });
      },
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: color.withOpacity(0.7)),
            child: Text(
              title,
              style: TextStyle(fontSize: 16, color: Colors.white),
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

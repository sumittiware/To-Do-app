import 'package:flutter/material.dart';
import 'package:to_do/Screens/urgenttask.dart';

class MyDrawer extends StatelessWidget {
  Function setDrawer;
  MyDrawer(this.setDrawer);
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
            height: height,
            width: width,
            color: Colors.transparent.withOpacity(0.8)),
        Container(
            height: height * 0.6,
            width: width * 0.8,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(width * 0.4),
                ),
                color: Color(0xFFA090F0)),
            child: Column(
              children: [
                SizedBox(height: 2 * MediaQuery.of(context).padding.top),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        icon: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () {
                          setDrawer();
                        }),
                    SizedBox(
                      width: width * 0.1,
                    ),
                    Text(
                      'Hii Sumit!!!',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )
                  ],
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(UrgentTasksPage.routename);
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    width: double.infinity,
                    height: height * 0.1,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.transparent.withOpacity(0.2)),
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Urgent/ Important tasks',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  width: double.infinity,
                  height: height * 0.1,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.transparent.withOpacity(0.2)),
                  child: Align(
                      alignment: Alignment.center,
                      child: Text('About Us',
                          style: TextStyle(color: Colors.white, fontSize: 18))),
                )
              ],
            )),
      ],
    );
  }
}

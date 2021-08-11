import 'package:flutter/material.dart';
import 'package:to_do/Config/config.dart';

class CustomAppBar extends StatefulWidget {
  // const CustomAppBar({ Key? key }) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool _openDrawer = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final padding = MediaQuery.of(context).padding.top;
    void _moreMenu(BuildContext ctx) {
      setState(() {
        _openDrawer = !_openDrawer;
      });
    }

    return Material(
      elevation: 10,
      borderRadius: BorderRadius.only(
          bottomRight: (!_openDrawer)
              ? Radius.circular(height * 0.4)
              : Radius.circular(10),
          bottomLeft:
              (!_openDrawer) ? Radius.circular(0) : Radius.circular(10)),
      child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.ease,
          padding: EdgeInsets.all(20),
          height: ((!_openDrawer) ? 100 : 300) + padding,
          width: width,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: appbarGradient),
              borderRadius: BorderRadius.only(
                  bottomRight: (!_openDrawer)
                      ? Radius.circular(height * 0.4)
                      : Radius.circular(10),
                  bottomLeft: (!_openDrawer)
                      ? Radius.circular(0)
                      : Radius.circular(10))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: padding,
              ),
              Container(
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        (!_openDrawer)
                            ? Icons.menu_rounded
                            : Icons.keyboard_arrow_up_outlined,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        _moreMenu(context);
                      },
                    ),
                    SizedBox(
                      width: width * 0.1,
                    ),
                    Text(
                      'To-Do',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                  ],
                ),
              ),
              (_openDrawer)
                  ? Container(
                      height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Material(
                            color: Colors.white30,
                            borderRadius: BorderRadius.circular(10),
                            child: ListTile(
                              onTap: share,
                              leading: Icon(
                                Icons.share,
                                size: 25,
                                color: Colors.white,
                              ),
                              title: Text(
                                "Share",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),
                          Material(
                            color: Colors.white30,
                            borderRadius: BorderRadius.circular(10),
                            child: ListTile(
                              onTap: rateUs,
                              leading: Icon(
                                Icons.star,
                                size: 25,
                                color: Colors.white,
                              ),
                              title: Text(
                                "Rate app",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),
                          Material(
                            color: Colors.white30,
                            borderRadius: BorderRadius.circular(10),
                            child: ListTile(
                              onTap: aboutMe,
                              leading: Icon(
                                Icons.info_rounded,
                                size: 25,
                                color: Colors.white,
                              ),
                              title: Text(
                                "About Us",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  : Container()
            ],
          )),
    );
  }
}

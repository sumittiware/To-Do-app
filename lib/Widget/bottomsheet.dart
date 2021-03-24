import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:to_do/Config/config.dart';
import 'package:url_launcher/url_launcher.dart';

class MyBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
        height: height * 0.3,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: share,
                child: ListTile(
                  leading: Icon(
                    Icons.share,
                    size: 25,
                    color: buttonColor,
                  ),
                  title: Text(
                    "Share",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              Divider(),
              InkWell(
                onTap: rateUs,
                child: ListTile(
                  leading: Icon(Icons.star, size: 25, color: buttonColor),
                  title: Text(
                    "Rate app",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              Divider(),
              InkWell(
                onTap: aboutMe,
                child: ListTile(
                  leading: Icon(Icons.info, size: 25, color: buttonColor),
                  title: Text(
                    "About me",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  //function to share the app using flutter
  Future<void> share() async {
    await FlutterShare.share(
        title: 'To-Do',
        text: 'Use this app to manage your daily tasks',
        linkUrl:
            'https://play.google.com/store/apps/details?id=com.sgttodolist',
        chooserTitle: 'Example Chooser Title');
  }

  //functio to redirect user to app page
  void rateUs() {
    StoreRedirect.redirect(
      androidAppId: "com.sgttodolist",
    );
  }

  //function for about us functionality
  void aboutMe() async {
    const url = 'https://www.instagram.com/sumit_tiware_';
    if (await canLaunch(url)) {
      await launch(url);
    } else {}
  }
}

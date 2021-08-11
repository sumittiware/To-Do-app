import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:url_launcher/url_launcher.dart';

List<Color> appbarGradient = [Color(0xFFFF512F), Color(0xFFDD2476)];
final buttonColor = Color(0xFFDD2476);
final taskColor = Color(0xFFF48FB1);
final logoPath = 'assets/icons/icon.png';
final emptyimage = 'assets/images/empty.png';

//function to share the app using flutter
Future<void> share() async {
  await FlutterShare.share(
      title: 'To-Do',
      text: 'Use this app to manage your daily tasks',
      linkUrl: 'https://play.google.com/store/apps/details?id=com.sgttodolist',
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

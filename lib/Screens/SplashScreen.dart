import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static const routename = 'splashscreen';
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFF8D0A0),
        body: Container(
          height: height,
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: height * 0.2,
                width: height * 0.2,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/logo.png'),
                        fit: BoxFit.cover)),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Text(
                'Task Manager',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: height * 0.2,
              ),
              CircularProgressIndicator()
            ],
          ),
        ),
      ),
    );
  }
}

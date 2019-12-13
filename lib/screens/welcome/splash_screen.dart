import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rescue/screens/auth/login_view.dart';
import 'package:rescue/screens/welcome/get_started.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() { 
    Timer(Duration(seconds: 4), () {
            Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          return LoginScreen();
        }));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double deviceWidth = size.width;

    return Scaffold(
      body: Container(
      color: Colors.white,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[
            Image.asset("assets/images/LOGO.png", width: deviceWidth / 2, ),
            SizedBox(width: 10.0,),
            Text(
              'RESCUE',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30.0,
                fontWeight: FontWeight.w800
              ),
            ),
          ],
        ),
      ),
    )
    );
  }
}
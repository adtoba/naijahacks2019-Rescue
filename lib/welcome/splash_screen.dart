import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rescue/welcome/get_started.dart';

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
          return GetStarted();
        }));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[
            Icon(Icons.add_box, size: 40.0,),
            SizedBox(height: 10.0,),
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
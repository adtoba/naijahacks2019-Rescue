import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double deviceHeight = size.height;
    double deviceWidth = size.width;

    return Scaffold(
     body: Stack(
       children: <Widget>[
         Container(
           height: deviceHeight,
           width: deviceWidth,
         ),
         
         SingleChildScrollView(
           child: Column(
             children: <Widget>[
               
             ],
           ),
         )
       ],
     )
    );
  }
}
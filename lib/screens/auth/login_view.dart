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
     body: Container(
       margin: EdgeInsets.all(20.0),
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
            SizedBox(height: 10.0,),
           TextFormField(
             decoration: InputDecoration(
               hintText: 'Email',
               border: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(20.0)
               )
             ),
           ),
           SizedBox(height: 10.0,),
           TextFormField(
             decoration: InputDecoration(
               hintText: 'Password',
               border: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(20.0)
               )
             ),
           ),

           SizedBox(height: 20.0,),

           Align(
             alignment: Alignment.bottomCenter,
             child: Container(
               width: deviceWidth /2,
               height: 50.0,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(10.0),
                 color: Colors.blue
               ),
               child: Center(
                 child: Text(
                   'LOGIN', style: TextStyle(
                     color: Colors.white
                   ),
                 ),
               ),
             ),
           ),

           SizedBox(height: 20.0,),

           RichText(
             text: TextSpan(
               children: [
                 TextSpan(
                   text: 'Not registered?'
                 ),
                 TextSpan(
                   text: 'Click to register'
                 )
               ]
             ),
           )

         ],
       ),
     ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:rescue/screens/auth/login_view.dart';
import 'package:rescue/screens/home/home_view.dart';

class GetStarted extends StatefulWidget {
  @override
  _GetStartedState createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double deviceHeight = size.height;
    double deviceWidth = size.width;

    return Scaffold(
      body: Container(
        color: Colors.white,
        height: deviceHeight,
        width: deviceWidth,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 24, left: 24.0, right: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 40.0,
                ),
                Center(
                    child: Image.asset(
                  "assets/images/fireworks.png",
                  height: 150.0,
                )),
                SizedBox(
                  height: 40.0,
                ),
                Text(
                  'Get started',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'A project that focuses on the safety of citizens by providing a means of'
                  ' reporting critical criminal activities to people around for rescue. \n'
                  '- It aims to provide a suitable means of savaging criminal activities to provide safety for citizens. \n'
                  '- To provide real-time location update on where a criminal activity is going on. \n'
                  '- Ability to alert suitable force in relation to the crime taking place. \n'
                  '- Reduce rate of criminal activities in neighbourhoods. \n'
                  '- Provide a feel-of-relief for citizens when currently in a criminal situation. ',
                  style: TextStyle(color: Colors.black54, fontSize: 16.0),
                ),
                SizedBox(
                  height: 30.0,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return HomeScreen();
                    }));
                  },
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    width: deviceWidth,
                    height: 50.0,
                    decoration: BoxDecoration(color: Colors.blue),
                    child: Center(
                      child: Text(
                        'NEXT',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

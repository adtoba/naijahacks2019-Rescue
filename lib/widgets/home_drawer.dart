import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rescue/constants/preferences.dart';
import 'package:rescue/models/user.dart';
import 'package:rescue/screens/auth/login_view.dart';
import 'package:rescue/screens/home/panic_view.dart';
import 'package:rescue/screens/registration/authorities_view.dart';
import 'package:rescue/screens/registration/trustees_view.dart';
import 'package:rescue/utils/preferences.dart';

class HomeDrawer extends StatefulWidget {

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  User _user;
  String userId;
  @override
  void initState() {
    
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            // accountName: Text('$userId'),
            // // accountEmail: Text(_user.email != null ? _user.email : 'NaN'),
            // onDetailsPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                 ListTile(
                  leading: Icon(Icons.notifications_active),
                 title: Text('Panics'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context)
                      .push(MaterialPageRoute(
                        builder: (context) {
                          return PanicScreen();
                        }
                      ));
                  },
                ),

                ListTile(
                  leading: Icon(Icons.people),
                  title: Text('Trustees'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context)
                      .push(MaterialPageRoute(
                        builder: (context) {
                          return TrusteesScreen();
                        }
                      ));
                  },
                ),

                SizedBox(height: 10.0,),

                ListTile(
                  leading: Icon(Icons.check_circle),
                  title: Text('Authorities'),
                  onTap: () {
                    Navigator.pop(context);
                     Navigator.of(context)
                      .push(MaterialPageRoute(
                        builder: (context) {
                          return AuthoritiesScreen();
                        }
                      ));
                  },
                ),

                SizedBox(height: 10.0,),

                ListTile(
                  leading: Icon(Icons.remove),
                  title: Text('Logout'),
                  onTap: () {
                     Navigator.pop(context);
                     Navigator.of(context)
                      .push(MaterialPageRoute(
                        builder: (context) {
                          return LoginScreen();
                        }
                      ));
                    Navigator.pop(context);
                  },
                ),

              ],
            ),
          )
        ],
      ),
    );
  }
}

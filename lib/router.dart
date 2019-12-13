

import 'package:flutter/material.dart';
import 'package:rescue/screens/auth/login_view.dart';
import 'package:rescue/screens/home/home_view.dart';
import 'package:rescue/screens/welcome/get_started.dart';
import 'package:rescue/screens/welcome/splash_screen.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/splashscreen' :
        return  MaterialPageRoute(
          builder: (_)=> SplashScreen()
        );
     
      case '/getstarted' :
        return MaterialPageRoute(
          builder: (_)=> GetStarted()
        ) ;
      case '/login' :
        return MaterialPageRoute(
          builder: (_) => LoginScreen()
        );
      case '/home' :
        return MaterialPageRoute(
          builder: (_)=> HomeScreen()
        ) ;
        
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            ));
    }
  }
}
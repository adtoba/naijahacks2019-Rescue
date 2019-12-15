import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rebloc/rebloc.dart';
import 'package:rescue/bloc/provider/viewmodels/panics_model.dart';
import 'package:rescue/bloc/provider/viewmodels/trustee_model.dart';
import 'package:rescue/bloc/states/main.dart';
import 'package:rescue/bloc/store.dart';
import 'package:rescue/locator.dart';
import 'package:rescue/models/trustees.dart';
import 'package:rescue/router.dart';
import 'package:rescue/screens/auth/login_view.dart';
import 'package:rescue/screens/home/home_view.dart';
import 'package:rescue/screens/registration/authorities_view.dart';
import 'package:rescue/screens/registration/trustees_view.dart';
import 'package:rescue/screens/welcome/get_started.dart';
import 'package:rescue/screens/welcome/splash_screen.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => locator<TrusteeModel>(),),
        ChangeNotifierProvider(builder: (_) => locator<PanicsModel>(),)
      ],
          child: StoreProvider<AppState>(
            store: appStore,
            child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            fontFamily: 'MuseoSans',
            primarySwatch: Colors.blue,
          ),
          home: SplashScreen(),
        ),
      ),
    );
  }
}


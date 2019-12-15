import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:rescue/bloc/provider/services/auth_services.dart';
import 'package:rescue/locator.dart';


class PanicsModel extends ChangeNotifier {

   final AuthService authService = locator<AuthService>();

  Stream<QuerySnapshot> getPanics() {
    var success =  authService.streamPanicCollection();

    return success;

  }
 
 
}
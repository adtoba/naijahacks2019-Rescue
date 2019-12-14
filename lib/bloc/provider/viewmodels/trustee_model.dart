import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rescue/bloc/provider/services/auth_services.dart';
import 'package:rescue/locator.dart';

class TrusteeModel extends ChangeNotifier {

  final AuthService authService = locator<AuthService>();

  Stream<QuerySnapshot> getDocuments() {
    var success =  authService.streamDataCollection();

    return success;

  }
 

}
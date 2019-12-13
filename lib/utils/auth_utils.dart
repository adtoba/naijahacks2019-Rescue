import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:rescue/constants/preferences.dart';


class FirebaseUtils {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<AuthResult> loginUser(String email, String password) async {
    var result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password
    );

    return result;
  }


  Future<AuthResult> createUser(String email, String password) async {
    var result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password
    );

    return result;
  }

  Future<dynamic> postUser(Map<String, dynamic> userDetails, String userId) async {
    final databaseReference = FirebaseDatabase.instance.reference();
    var result = await databaseReference.child(USER_COLLECTION).child(userId).child('details').push()
      .set(userDetails);
    
    return result;
  }

  Future<dynamic> postData(Map<String, dynamic> map, String userId, String path) async {
    final databaseReference = FirebaseDatabase.instance.reference();

    var result = await databaseReference.child(USER_COLLECTION).child(userId).child(path)
      .push().set(map);

    return result;
  }

  

}
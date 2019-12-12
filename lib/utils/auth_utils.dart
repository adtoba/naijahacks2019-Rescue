import 'package:firebase_auth/firebase_auth.dart';


class FirebaseUtils {

  static Future<AuthResult> loginUser(String email, String password) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    var result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password
    );

    return result;
  }


  static Future<AuthResult> createUser(String name, String email, String password) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    var result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password
    );

    return result;
  }

}
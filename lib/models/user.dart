import 'package:meta/meta.dart';

class User {

  User(
    this._email,
    this._name,
    this._userId
    
  );

  String _name;
  String _email;
  String _userId;

  void setUserId(String userId) {
    this._userId = userId;
  }

  String get userId => _userId;
  String get name => _name;
  String get email => _email;

  User.fromMap(Map<String, dynamic> userMap) {
    this._name = userMap['name'];
    this._email = userMap['email'];
    this._userId = userMap['userId'];
  }

  Map<String, dynamic> toJson() {
    var map = Map<String, dynamic>(); 
    map['name'] = _name;
    map['email'] = _email;
    map['userId'] = _userId;

    return map;

  }
}
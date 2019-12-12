import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';


Future<dynamic> getPreference(String key) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  dynamic value = sharedPreferences.get(key);

  return value;
}


Future<bool> setPreference(String key, dynamic value) async {
  bool status;
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  if(value.runtimeType == bool) {
    status = await sharedPreferences.setBool(key, value);
  } else if(value.runtimeType == Double) {
    status = await sharedPreferences.setDouble(key, value);
  } else if(value.runtimeType == int) {
    status = await sharedPreferences.setInt(key, value);
  } else if(value.runtimeType == String) {
    status = await sharedPreferences.setString(key, value);
  }

  return status;
}


Future<bool> clearPreferences() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  bool status = await sharedPreferences.clear();

  return status;
}

Future<bool> removePreference(String key) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  bool status = await sharedPreferences.remove(key);

  return status;
}
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  
   final Firestore _db = Firestore.instance;
  final String path = "Trustees";
  final String panics = "Panics";
  CollectionReference ref;
  FirebaseAuth _auth;
  FirebaseUser _user;

  Future<QuerySnapshot> getDataCollection() {
    ref = _db.collection(path);
    return ref.getDocuments();
  }

  Stream<QuerySnapshot> streamPanicCollection() {
    ref = _db.collection(panics);
    return ref.snapshots();
  }

  Stream<QuerySnapshot> streamDataCollection() {
    ref = _db.collection(path);
    return ref.snapshots();
  }

  
}

import 'package:flutter/material.dart';
import 'package:rescue/bloc/methods/status.dart';
import 'package:rescue/models/trustees.dart';

@immutable
class GetTrustees {
  const GetTrustees({
    @required this.status,
    @required this.trustees,
    @required this.trusteesMessage
  }); 

  final Status status;
  final Trustees trustees;
  final String trusteesMessage;


  const GetTrustees.initialState() 
    : status = Status.UNLOADED,
      trustees = null,
      trusteesMessage = '';

  
  // GetTrustees copyWith({

  // }) {

  // }


}
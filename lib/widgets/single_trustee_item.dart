import 'package:flutter/material.dart';


class SingleTrusteeItem extends StatelessWidget {
  SingleTrusteeItem({
    @required this.email,
    @required this.phoneNumber,
    @required this.fullName
  });

  final String email;
  final String phoneNumber;
  final String fullName;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.bookmark
      ),
      title: Text('$fullName'),
      subtitle: Text('$phoneNumber'),
    );
  }
}
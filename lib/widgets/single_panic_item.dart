import 'package:flutter/material.dart';

class SinglePanicItem extends StatelessWidget {
  SinglePanicItem(
      {@required this.senderEmail,
      @required this.attackType,
      @required this.senderAddress,
      @required this.lat,
      @required this.long});

  String senderAddress;
  String senderEmail;
  String attackType;
  String lat;
  String long;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: Icon(Icons.remove_circle, color: Colors.red),
      title: Text('$attackType'),
      children: <Widget>[
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 80.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Attack type: $attackType'),
                SizedBox(
                  height: 5.0,
                ),
                Text('Address: $senderAddress'),
                SizedBox(
                  height: 5.0,
                ),
                Text('Email: $senderEmail'),
                SizedBox(
                  height: 5.0,
                ),
                Text('LatLng: $lat, $long'),
                SizedBox(
                  height: 5.0,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

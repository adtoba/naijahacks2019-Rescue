import 'package:flutter/material.dart';

class SingleAuthorityItem extends StatelessWidget {
  SingleAuthorityItem({@required this.phoneNumber, @required this.state, @required this.onPressed});

  List phoneNumber;
  String state;
  Function onPressed;
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      
      leading: IconButton(
        icon: Icon(Icons.call, color: Colors.green,),
        onPressed: () {
          onPressed();
        },
      ),

      title: Text(
        '$state'
      ),
     
     children: <Widget>[
       Align(
         alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 80.0, bottom: 10.0),
                  child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           mainAxisAlignment: MainAxisAlignment.start,
           children: phoneNumber.map((number) => Row(
             children: <Widget>[
               Icon(Icons.remove, size: 20.0, color: Colors.red,),
               SizedBox(width: 10.0,),
               Text('$number', style: TextStyle(fontSize: 16, color: Colors.grey),),
             ],
           )).toList(),
         ),
                ),
       )
     ],
      
    );
  }
}
import 'package:flutter/material.dart';

class SingleItem extends StatelessWidget {

  SingleItem({@required this.content, this.color});

 final  String content;
 final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      height: 30.0,
      child: Card(
        color: color,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        child: Center(
          child: Text('$content'),
        ),
            
      ),
    );
  }
}
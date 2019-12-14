import 'package:flutter/material.dart';

class SingleItem extends StatelessWidget {

  SingleItem({@required this.content, this.color, this.isSelected = false});

 final  String content;
 final Color color;
 bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      height: 50.0,
      child: Card(
        color: isSelected ? color : Colors.blue,
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        child: Center(
          child: Text('$content', style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
        ),
            
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:rescue/utils/json.dart';
import 'package:rescue/widgets/single_authority_item.dart';

class AuthoritiesScreen extends StatefulWidget {
  @override
  _AuthoritiesScreenState createState() => _AuthoritiesScreenState();
}

class _AuthoritiesScreenState extends State<AuthoritiesScreen> {

  List<Authority> _authorities = authorities;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double deviceHeight = size.height;
    double deviceWidth = size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        title: Text('Authorities', style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){Navigator.pop(context);},
        ),
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        backgroundColor: Colors.white,
      ),

      body: Stack(
        children: <Widget>[
          Container(
            height: deviceHeight,
            width: deviceWidth,
          ),

         ListView(
           children: _authorities.map((authorities) => SingleAuthorityItem(
             state: authorities.state,
             phoneNumber: authorities.phoneNumbers,
             onPressed: (){},
           )).toList(),
         )
        
        ],
      ),
    );
  }
}



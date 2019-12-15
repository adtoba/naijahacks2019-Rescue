import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rescue/bloc/provider/viewmodels/panics_model.dart';
import 'package:rescue/models/panics.dart';
import 'package:rescue/widgets/single_panic_item.dart';


class PanicScreen extends StatefulWidget {
  @override
  _PanicScreenState createState() => _PanicScreenState();
}

class _PanicScreenState extends State<PanicScreen> {

  List<Panics> panicsList;


  @override
  Widget build(BuildContext context) {

    final model = Provider.of<PanicsModel>(context);

    return Scaffold(
      appBar: AppBar(
         elevation: 1.0,
        title: Text('Panics', style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){Navigator.pop(context);},
        ),
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        backgroundColor: Colors.white,
      ),


      body: StreamBuilder(
        stream: model.getPanics(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            panicsList = snapshot.data.documents
                .map((doc) => Panics.fromJson(doc.data))
                .toList();

            return ListView.builder(
              itemCount: panicsList.length,
              itemBuilder: (context, position) {
                return SinglePanicItem(
                  senderAddress: panicsList[position].senderAddress,
                  senderEmail: panicsList[position].senderEmail,
                  attackType: panicsList[position].attackType,
                  lat: panicsList[position].lat.toString(),
                  long: panicsList[position].long.toString(),
                );
              },
            );
          } else {
            return Text('Fetching');
          }
        },
      ),
      
    );
  }
}
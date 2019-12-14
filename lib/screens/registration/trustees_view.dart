import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:rescue/bloc/provider/viewmodels/trustee_model.dart';
import 'package:rescue/models/trustees.dart';
import 'package:rescue/widgets/single_trustee_item.dart';

class TrusteesScreen extends StatefulWidget {
  @override
  _TrusteesScreenState createState() => _TrusteesScreenState();
}

class _TrusteesScreenState extends State<TrusteesScreen> {
  PersistentBottomSheetController _controller;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  CollectionReference _ref;
  final Firestore _db = Firestore.instance;
  final String path = "Trustees";

  List<Trustees> trusteesList;
  var streamData;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<TrusteeModel>(context);
    Size size = MediaQuery.of(context).size;
    double deviceHeight = size.height;
    double deviceWidth = size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        title: Text(
          'Trustees',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
      ),
      body: StreamBuilder(
        stream: model.getDocuments(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            trusteesList = snapshot.data.documents
                .map((doc) => Trustees.fromJson(doc.data))
                .toList();

            return ListView.builder(
              itemCount: trusteesList.length,
              itemBuilder: (context, position) {
                return SingleTrusteeItem(
                  email: trusteesList[position].email,
                  phoneNumber: trusteesList[position].phoneNumber,
                  fullName: trusteesList[position].name,
                );
              },
            );
          } else {
            return Text('Fetching');
          }
        },
      ),

      //   ],
      // ),
      floatingActionButton: FloatingActionButton(
        elevation: 5,
        backgroundColor: Colors.red,
        child: Center(
            child: Icon(
          Icons.add,
          color: Colors.white,
        )),
        onPressed: () {
          showAddTrusteeDialog(context, deviceWidth);
        },
      ),
    );
  }

  void showAddTrusteeDialog(BuildContext context, double deviceWidth) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              splashColor: Colors.red,
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("NO THANKS"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              splashColor: Colors.blue,
              onTap: () async {
                Map<String, dynamic> trusteeMap = {
                  'name': _fullNameController.text,
                  'email': _emailController.text,
                  'phoneNumber': _phoneNumberController.text
                };

                await addDocument(trusteeMap).then((response) {
                  showSnackBar('${response.documentID}', context);
                 
                });

                 Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("OK"),
              ),
            ),
          ),
        ],
        title: Row(
          children: <Widget>[
            Icon(
              Icons.add,
              color: Colors.red,
            ),
            SizedBox(
              width: 5.0,
            ),
            Text('Add new trustee'),
          ],
        ),
        contentPadding: EdgeInsets.all(20.0),
        content: Container(
          height: 250,
          child: SingleChildScrollView(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Text('New trustee'),
                // ),
                TextFormField(
                  controller: _fullNameController,
                  decoration: InputDecoration(
                      hintText: 'Full name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  controller: _phoneNumberController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      hintText: 'Phone number',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      hintText: 'Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                ),

                SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<DocumentReference> addDocument(Map data) {
    _ref = _db.collection(path);
    return _ref.add(data);
  }

  Stream<QuerySnapshot> streamDataCollection() {
    _ref = _db.collection(path);
    return _ref.snapshots();
  }

  showSnackBar(String content, BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        content,
        style: TextStyle(color: Colors.white, fontFamily: 'MuseoSans'),
      ),
    ));
  }
}

class _SystemPadding extends StatelessWidget {
  final Widget child;

  _SystemPadding({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return new AnimatedContainer(
        padding: mediaQuery.viewInsets,
        duration: const Duration(milliseconds: 300),
        child: child);
  }
}

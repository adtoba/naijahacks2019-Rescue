import 'dart:async';

import 'package:app_settings/app_settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rescue/models/user.dart';

import 'package:rescue/utils/permission_services.dart';
import 'package:rescue/widgets/home_drawer.dart';
import 'package:rescue/widgets/single_item.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Geolocator _geolocator = Geolocator();
  String dropdownValue = 'All';
  Position position;
  bool isBuilt = false;
  bool isSendingSignal = false;
  bool currentTrusteeValue = false;
  bool currentAuthorityValue = false;
  bool isLocationDerived = false;
  bool permissionRequestAsked = false;
  final Completer<GoogleMapController> _controller = Completer();
  final PermissionService permissionService = PermissionService();
  StreamSubscription<Position> _positionStream;
  final LocationOptions _locationOptions = LocationOptions(
      timeInterval: 10, accuracy: LocationAccuracy.bestForNavigation);
  String _currentAddress;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final List<String> possibleAttacks = [
    'Robbery',
    'Kidnapping',
    'Electric',
    'Accident',
    'Abuse',
    'Harrassment',
    'Suspicious activity'
  ];

  CollectionReference _ref;
  final Firestore _db = Firestore.instance;
  final String path = "Panics";
  User user;

  @override
  void initState() {
    permissionService.requestLocationPermission(onPermissionDenied: () {
      print("Permission has been denied");
    });
    locationPrompt();

    super.initState();
  }

  void locationUpdater(Function f) async {
    _positionStream =
        _geolocator.getPositionStream(_locationOptions).listen((newPosition) {
      if (mounted) {
        if (newPosition != null) {
          if (newPosition != position) {
            setState(() {
              position = newPosition;
            });
          }
        }
      }
    });
  }

  void locationPrompt() async {
    bool isLocationEnabled = await Geolocator().isLocationServiceEnabled();

    if (!isLocationEnabled) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(
                  "To continue, turn on device location (GPS), which uses your device location service."),
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
                    onTap: () {
                      AppSettings.openLocationSettings();
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("OK"),
                    ),
                  ),
                ),
              ],
            );
          });
    }
  }

  _getAddressFromPosition() async {
    try {
      List<Placemark> p = await _geolocator.placemarkFromCoordinates(
          position.latitude, position.longitude);
      Placemark place = p[0];

      setState(() {
        _currentAddress =
            "${place.isoCountryCode},${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  void getLocation() async {
    bool isLocationEnabled = await Geolocator().isLocationServiceEnabled();
    if (isLocationEnabled) {
      await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
          .then((newPosition) {
        setState(() {
          position = newPosition;
          isLocationDerived = true;
        });
      });
      // print('LONGITUDE IS: ${position.longitude}');
      // getUserDetails();
    } else {
      setState(() {
        position = Position(
          latitude: 9.072264,
          longitude: 7.491302,
        );
        isLocationDerived = true;
      });

      // getUserDetails();
    }
  }

  @override
  Widget build(BuildContext context) {
    locationUpdater(() {});

    getLocation();

    _getAddressFromPosition();

    return Scaffold(
      key: _scaffoldKey,
      drawer: HomeDrawer(),
      body: Stack(
        children: <Widget>[
          isLocationDerived
              ? GoogleMap(
                  mapType: MapType.normal,
                  zoomGesturesEnabled: true,
                  indoorViewEnabled: true,
                  myLocationButtonEnabled: true,
                  initialCameraPosition: CameraPosition(
                      target: LatLng(position?.latitude ?? 9.072264,
                          position?.longitude ?? 7.491302),
                      zoom: 16.5),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  myLocationEnabled: true,
                  padding: EdgeInsets.only(top: 20.0),
                )
              : Container(
                  child: Center(
                    child: Text('Location not derived'),
                  ),
                ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(top: 40.0, left: 20.0),
              child: Row(
                children: <Widget>[
                  GestureDetector(
                      onTap: () {
                        _scaffoldKey.currentState.openDrawer();
                      },
                      child: Icon(Icons.menu, color: Colors.black)),
                  SizedBox(
                    width: 20.0,
                  ),
                  Text(
                    'Rescue',
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(
                          builder: (BuildContext context,
                              StateSetter setModalState) {
                            return Container(
                              height: 300.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Checkbox(
                                          onChanged: (value) {
                                            setModalState(() {
                                              currentAuthorityValue = value;
                                            });
                                          },
                                          value: currentAuthorityValue,
                                        ),
                                        Text('Trustees'),
                                        Checkbox(
                                          onChanged: (value) {
                                            setModalState(() {
                                              currentTrusteeValue = value;
                                            });
                                          },
                                          value: currentTrusteeValue,
                                        ),
                                        Text('Authorities'),
                                        DropdownButton<String>(
                                          value: dropdownValue,
                                          icon: Icon(Icons.arrow_drop_down),
                                          iconSize: 24,
                                          elevation: 16,
                                          onChanged: (String newValue) {
                                            setModalState(() {
                                              dropdownValue = newValue;
                                            });
                                          },
                                          items: <String>['All', 'Others']
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ],
                                    ),

                                    // Padding(
                                    //   padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                                    //   child: SingleChildScrollView(
                                    //     scrollDirection: Axis.horizontal,
                                    //     child: Row(
                                    //       mainAxisAlignment:
                                    //           MainAxisAlignment.spaceEvenly,
                                    //       crossAxisAlignment:
                                    //           CrossAxisAlignment.start,
                                    //       children: possibleAttacks
                                    //           .map((attacks) => SingleItem(
                                    //                 content: attacks,
                                    //               ))
                                    //           .toList(),
                                    //     ),
                                    //   ),
                                    // ),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        SingleItem(
                                          isSelected: true,
                                          content: 'Robbery',
                                        ),
                                        SingleItem(
                                          content: 'Kidnapping',
                                        ),
                                        SingleItem(
                                          content: 'Electric',
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        SingleItem(
                                          content: 'Accident',
                                        ),
                                        SingleItem(
                                          content: 'Abuse',
                                        ),
                                        SingleItem(
                                          content: 'Harrassment',
                                        ),
                                      ],
                                    ),

                                    SizedBox(
                                      height: 20.0,
                                    ),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        SingleItem(
                                          content: 'Robbery',
                                        ),
                                        SingleItem(
                                          isSelected: true,
                                          content: 'Kidnapping',
                                        ),
                                        SingleItem(
                                          content: 'Electric',
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 10.0, top: 10.0),
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: () async {
                                                double lat;
                                                double long;
                                                if (position.latitude == null) {
                                                  lat = 0.0;
                                                } else {
                                                  lat = position.latitude;
                                                }

                                                if (position.longitude ==
                                                    null) {
                                                  long = 0.0;
                                                } else {
                                                  long = position.longitude;
                                                }

                                                Map<String, dynamic> data = {
                                                  "senderAddress":
                                                      _currentAddress,
                                                  "senderEmail":
                                                      'adetoba54@gmail.com',
                                                  "attackType": 'Robbery',
                                                  "lat": lat,
                                                  "long": long
                                                };

                                                setModalState(() {
                                                  isSendingSignal = true;
                                                });

                                                await addDocument(data)
                                                    .then((response) {
                                                  setModalState(() {
                                                    isSendingSignal = false;
                                                    Navigator.pop(context);
                                                  });
                                                });
                                              },
                                              child: Container(
                                                width: 200.0,
                                                height: 40.0,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                    color: Colors.red),
                                                child: Center(
                                                  child: Text('PROCEED',
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5.0,
                                            ),
                                            Visibility(
                                                visible: isSendingSignal,
                                                child:
                                                    CircularProgressIndicator())
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 40.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey)),
                      child: Center(
                        child: Icon(Icons.videocam),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Container(
                      width: 80.0,
                      height: 80.0,
                      child: Center(
                        child: Text(
                          'PANIC',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                        boxShadow: [
                          BoxShadow(color: Colors.green, blurRadius: 10)
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Container(
                      width: 40.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey)),
                      child: Center(
                        child: Icon(Icons.camera),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<DocumentReference> addDocument(Map data) {
    _ref = _db.collection(path);
    return _ref.add(data);
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:location/location.dart';

class MapSample1 extends StatefulWidget {
  @override
  State<MapSample1> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample1> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(7.219934, 100.577088),
    zoom: 15.5,
  );
  final databaseReference = FirebaseDatabase.instance.reference();
  var Latitude1;
  var Longitude1;
  var Latitude2;
  var Longitude2;
  var Latitude3;
  var Longitude3;
  var Latitude4;
  var Longitude4;

  @override
  void initState() {
    super.initState();
    _markerupdate();
  }

  void _markerupdate() {
    databaseReference.child('ferry1/latitude').onValue.listen((event) {
      final double Latitude01 = event.snapshot.value;
      setState(() {
        Latitude1 = Latitude01;
      });
    });

    databaseReference.child('ferry1/longitude').onValue.listen((event) {
      final double Longitude01 = event.snapshot.value;
      setState(() {
        Longitude1 = Longitude01;
      });
    });

    databaseReference.child('ferry2/latitude').onValue.listen((event) {
      final double Latitude02 = event.snapshot.value;
      setState(() {
        Latitude2 = Latitude02;
      });
    });

    databaseReference.child('ferry2/longitude').onValue.listen((event) {
      final double Longitude02 = event.snapshot.value;
      setState(() {
        Longitude2 = Longitude02;
      });
    });

    databaseReference.child('ferry3/latitude').onValue.listen((event) {
      final double Latitude03 = event.snapshot.value;
      setState(() {
        Latitude3 = Latitude03;
      });
    });

    databaseReference.child('ferry3/longitude').onValue.listen((event) {
      final double Longitude03 = event.snapshot.value;
      setState(() {
        Longitude3 = Longitude03;
      });
    });

    databaseReference.child('ferry4/latitude').onValue.listen((event) {
      final double Latitude04 = event.snapshot.value;
      setState(() {
        Latitude4 = Latitude04;
      });
    });

    databaseReference.child('ferry4/longitude').onValue.listen((event) {
      final double Longitude04 = event.snapshot.value;
      setState(() {
        Longitude4 = Longitude04;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('ตำแหน่งของแพขนานยนต์'),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        trafficEnabled: true,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: {
          Marker(
              markerId: MarkerId("ferry1"),
              position: LatLng(Latitude1, Longitude1),
              infoWindow: InfoWindow(
                title: "อบจ1",
              )),
          Marker(
              markerId: MarkerId("ferry2"),
              position: LatLng(Latitude2, Longitude2),
              infoWindow: InfoWindow(
                title: "อบจ2",
              )),
          Marker(
              markerId: MarkerId("ferry3"),
              position: LatLng(Latitude3, Longitude3),
              infoWindow: InfoWindow(
                title: "อบจ3",
              )),
          Marker(
              markerId: MarkerId("ferry4"),
              position: LatLng(Latitude4, Longitude4),
              infoWindow: InfoWindow(
                title: "อบจ4",
              )),
        },
      ),
    );
  }

  Future<void> _goToTheGooglePlex() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
  }
}

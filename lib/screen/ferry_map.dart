import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FerryMap extends StatefulWidget {
  @override
  State<FerryMap> createState() => FerryMapState();
}

class FerryMapState extends State<FerryMap> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(7.219934, 100.577088),
    zoom: 16,
  );

  final FirebaseFirestore collectionReferences = FirebaseFirestore.instance;

  late BitmapDescriptor customMarker;

  @override
  void initState() {
    _goToTheGooglePlex();
    _getCustomMarker();
    super.initState();
  }

  void _getCustomMarker() async {
    customMarker = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.5),
      'assets/images/ferryicon1.png',
    );
  }

  Set<Marker> _getPins(ships) {
    Set<Marker> markers = {};

    if (ships.docs.length != 0) {
      ships.docs.forEach(
        (ship) {
          print(ship.data());
          markers.add(
            Marker(
              markerId: MarkerId(ship.id),
              position: LatLng(
                ship.data()['location']['latitude'],
                ship.data()['location']['longitude'],
              ),
              icon: customMarker,
              infoWindow: InfoWindow(
                title: ship.data()['name'],
              ),
            ),
          );
        },
      );
    }

    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ตำแหน่งของแพขนานยนต์'),
        backgroundColor: Color(0xFF00ffcf),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: collectionReferences.collection('ships').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return GoogleMap(
            mapType: MapType.normal,
            trafficEnabled: true,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: _getPins(snapshot.data),
          );
        },
      ),
    );
  }

  Future<void> _goToTheGooglePlex() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(_kGooglePlex),
    );
  }
}

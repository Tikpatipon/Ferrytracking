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

  Set<Marker> _markers = {};

  @override
  void initState() {
    _goToTheGooglePlex();
    _getPins();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getPinsUpdate();
  }

  Future<void> _getPins() async {
    Set<Marker> markers = {};
    _markers.clear();
    await collectionReferences.collection('ships').get().then(
          (ships) => {
            if (ships.docs.length != 0)
              {
                ships.docs.forEach((ship) {
                  markers.add(
                    Marker(
                      markerId: MarkerId(ship.id),
                      position: LatLng(
                        ship.data()['location']['latitude'],
                        ship.data()['location']['longitude'],
                      ),
                      infoWindow: InfoWindow(
                        title: ship.data()['name'],
                      ),
                    ),
                  );
                })
              }
          },
        );
    setState(() {
      _markers = markers;
    });
  }

  Future<void> _getPinsUpdate() async {
    Set<Marker> markers = {};
    _markers.clear();
    collectionReferences.collection('ships').snapshots().listen(
          (ships) => {
            if (ships.docs.length != 0)
              {
                ships.docs.forEach((ship) {
                  markers.add(
                    Marker(
                      markerId: MarkerId(ship.id),
                      position: LatLng(
                        ship.data()['location']['latitude'],
                        ship.data()['location']['longitude'],
                      ),
                      infoWindow: InfoWindow(
                        title: ship.data()['name'],
                      ),
                    ),
                  );
                })
              }
          },
        );
    setState(() {
      _markers = markers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        markers: _markers,
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

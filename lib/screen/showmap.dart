import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_core/firebase_core.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(7.219934, 100.577088),
    zoom: 16,
  );

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
              position: LatLng(7.219934, 100.577088),
              infoWindow: InfoWindow(
                title: "อบจ1",
              )),
          Marker(
              markerId: MarkerId("ferry2"),
              position: LatLng(7.219934, 100.577088),
              infoWindow: InfoWindow(
                title: "อบจ2",
              )),
          Marker(
              markerId: MarkerId("ferry3"),
              position: LatLng(7.219934, 100.577088),
              infoWindow: InfoWindow(
                title: "อบจ3",
              )),
          Marker(
              markerId: MarkerId("ferry4"),
              position: LatLng(7.219934, 100.577088),
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

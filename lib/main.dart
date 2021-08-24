import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ferry_tracking/screen/realtime_video.dart';
import 'package:ferry_tracking/screen/ferry_map.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FerryTracking());
}

class FerryTracking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ferry Trackking',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FerryTrackingPage(
        title: 'Ferry Trackking',
      ),
    );
  }
}

class FerryTrackingPage extends StatefulWidget {
  FerryTrackingPage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  _FerryTrackingPageState createState() => _FerryTrackingPageState();
}

class _FerryTrackingPageState extends State<FerryTrackingPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: TabBarView(
          children: [
            FerryMap(),
            RealtimeVideo(),
          ],
        ),
        backgroundColor: Colors.blue,
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(
              text: "ตำแหน่งของแพขนานยนต์",
            ),
            Tab(
              text: "ภาพการจราจร",
            )
          ],
        ),
      ),
    );
  }
}

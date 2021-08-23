import 'package:ferrytracking/screen/showmap.dart';
import 'package:flutter/material.dart';
import 'package:ferrytracking/screen/videorealtime.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ferry Trackking',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Ferry Trackking Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          body: TabBarView(
            children: [MapSample(), Videorealtime()],
          ),
          backgroundColor: Colors.blue,
          bottomNavigationBar: TabBar(
            tabs: [
              Tab(
                text: "ตำแหน่งของแพขนานยนต์",
              ),
              Tab(
                text: "ภาพการจราจร",
              ),
            ],
          ),
        ));
  }
}

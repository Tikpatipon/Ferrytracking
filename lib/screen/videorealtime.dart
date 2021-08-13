import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mjpeg/flutter_mjpeg.dart';

class Videorealtime extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final isRunning = useState(true);
    return Scaffold(
        appBar: AppBar(
          title: Text('ภาพการจาราจร'),
        ),
        body: Center(
          child: Column(
            children: [
              Text("ภาพการจาราจรฝั่งเขาหัวแดง"),
              Mjpeg(
                isLive: isRunning.value,
                width: 500,
                height: 200,
                stream: 'http://58.8.138.21:8080/?action=stream',
              ),
              Text(" "),
              Text(" "),
              Text("ภาพการจาราจรฝั่งสงขลา"),
              Mjpeg(
                isLive: isRunning.value,
                width: 500,
                height: 200,
                stream: 'http://58.8.138.21:8080/?action=stream',
              ),
            ],
          ),
        ));
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';

class Traffic extends StatelessWidget {
  const Traffic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFffc0cb),
      appBar: AppBar(
        title: Text('ความหนาแน่นของรถที่มาใช้บริการ'),
        backgroundColor: Color(0xFF00ffcf),
      ),
      body: Center(
        child: Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text("สีเขียว", style: TextStyle(fontSize: 16)),
                Text(""),
                Image.asset('assets/images/green.png'),
                Text(""),
                Text("การจราจรคล่องตัว"),
                Text("รถที่รอใช้บริการโดยประมาณ"),
                Text("รถยนต์ 10 คัน รถจักรยานยนต์ 20 คัน"),
                Text(""),
                Text("สีส้ม", style: TextStyle(fontSize: 16)),
                Text(""),
                Image.asset('assets/images/orange.png'),
                Text(""),
                Text("การจราจรเริ่มหนาแน่น"),
                Text("รถที่รอใช้บริการโดยประมาณ"),
                Text("รถยนต์ 20 คัน รถจักรยานยนต์ 40 คัน"),
                Text(""),
                Text("สีแดง", style: TextStyle(fontSize: 16)),
                Text(""),
                Image.asset('assets/images/red.png'),
                Text(""),
                Text("การจราจรติดขัด"),
                Text("รถที่รอใช้บริการโดยประมาณ"),
                Text("รถยนต์ 30 คัน รถจักรยานยนต์ 60 คัน"),
                Text(""),
                Text("สีแดงเลือดหมู", style: TextStyle(fontSize: 16)),
                Text(""),
                Image.asset('assets/images/red2.png'),
                Text(""),
                Text("การจราจรติดขัดมาก "),
                Text("รถที่รอใช้บริการโดยประมาณ"),
                Text("รถยนต์ 40 คัน รถจักรยานยนต์ 80 คัน"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

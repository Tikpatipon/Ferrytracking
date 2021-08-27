import 'dart:ui';

import 'package:flutter/material.dart';

class Traffic extends StatelessWidget {
  const Traffic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFffc0cb),
      appBar: AppBar(
        title: Text('สถานะการจราจร'),
        backgroundColor: Color(0xFF00ffcf),
      ),
      body: Center(
        child: Column(
          children: [
            Text("สีเขียว: การจราจรไม่ล่าช้า"),
            Spacer(),
            Text("สีส้ม: ปริมาณการจราจรปานกลาง"),
            Spacer(),
            Text(
              "สีแดง: การจราจรล่าช้า สีแดงยิ่งเข้มแสดงว่าการจราจรบนถนนนั้นยิ่งเคลื่อนตัวได้ช้าลง ",
            ),
          ],
        ),
      ),
    );
  }
}

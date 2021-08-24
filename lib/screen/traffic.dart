import 'dart:ui';

import 'package:flutter/material.dart';

class traffic extends StatelessWidget {
  const traffic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          Text(" "),
          Text(" "),
          Text("สีเขียว: การจราจรไม่ล่าช้า"),
          Text(" "),
          Text(" "),
          Text(" "),
          Text(" "),
          Text("สีส้ม: ปริมาณการจราจรปานกลาง"),
          Text(" "),
          Text(" "),
          Text(" "),
          Text(" "),
          Text(
              "สีแดง: การจราจรล่าช้า สีแดงยิ่งเข้มแสดงว่าการจราจรบนถนนนั้นยิ่งเคลื่อนตัวได้ช้าลง "),
        ],
      ),
    ));
  }
}

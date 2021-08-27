import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mjpeg/flutter_mjpeg.dart';

class RealtimeVideo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFffc0cb),
      appBar: AppBar(
        title: Text('ภาพการจาราจร'),
        backgroundColor: Color(0xFF00ffcf),
      ),
      body: StreamBuilder<QuerySnapshot<Object?>>(
        stream: FirebaseFirestore.instance.collection('traffics').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final data = snapshot.requireData;

          return ListView.builder(
            itemCount: data.size,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => toggleLivePreview(data.docs[index].id),
                child: Container(
                  margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Column(
                    children: [
                      Text(
                        data.docs[index]['name'],
                        style: TextStyle(fontSize: 15.0),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Mjpeg(
                        isLive: data.docs[index]['is_live'],
                        width: 500,
                        height: 210,
                        stream: data.docs[index]['link'],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void toggleLivePreview(String docID) {
    FirebaseFirestore.instance.collection('traffics').doc(docID).get().then(
          (traffic) => {
            if (traffic.exists)
              {
                FirebaseFirestore.instance
                    .collection('traffics')
                    .doc(docID)
                    .update({
                  "is_live": !traffic['is_live'],
                  "updated_at": DateTime.now()
                })
              }
          },
        );
  }
}

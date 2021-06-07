import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



class Messges extends StatelessWidget {
  const Messges({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('chat').snapshots(),
      builder: (ctx, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        final chatDocs = snapshot.data.documents;

        return ListView.builder(
          itemCount: chatDocs.length,
          itemBuilder: (ctx, index) => Text(chatDocs[index]["text"]),
        );
      },
    );
  }
}
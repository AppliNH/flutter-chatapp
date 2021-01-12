import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('chats/1hcFV9aWCsZmB699EykD/messages')
            .snapshots(), // returns a stream (real-time data),
        builder: (ctx, streamSnap) {
          
            if (streamSnap.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator()
              );
            }
            final documents = streamSnap.data.documents;
            return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (ctx, index) => Container(
                    padding: const EdgeInsets.all(8),
                    child: Text(documents[index]["text"])),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.message),
        onPressed: () {},
      ),
    );
  }
}

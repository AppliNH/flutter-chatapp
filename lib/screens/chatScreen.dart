import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chatapp/widgets/chat/messages.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text("ChatApp"),
        actions: [
          DropdownButton(
            icon: Icon(Icons.more_vert),
            items: [
              DropdownMenuItem(value: 'logout',child: Container(child: Row(children: [
                Icon(Icons.exit_to_app),
                SizedBox(width:8),
                Text("Logout")
              ],),),)
            ],
            onChanged: (itemId) {
              switch (itemId) {
                case 'logout':
                  FirebaseAuth.instance.signOut();
                  break;
                default:
              }
            },

          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Messges()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.message),
        onPressed: () {
          Firestore.instance.collection('chats/1hcFV9aWCsZmB699EykD/messages').add({
            "text": "Noice"
          });
        },
      ),
    );
  }
}

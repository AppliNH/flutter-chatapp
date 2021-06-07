import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatapp/screens/authScreen.dart';
import 'package:flutter_chatapp/screens/chatScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.white),
          bodyText2: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        accentColor: Colors.blue,
        buttonTheme: ButtonTheme.of(context).copyWith(
          
          buttonColor: Colors.blue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
        )

      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) { // User is logged
            return ChatScreen();
          }
          return AuthScreen();
        }, ),
    );
  }
}

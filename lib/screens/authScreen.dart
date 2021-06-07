import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chatapp/widgets/auth/authForm.dart';

class AuthScreen extends StatefulWidget {
  AuthScreen({Key key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  final _auth = FirebaseAuth.instance;
  final _store = Firestore.instance;

  var _isLoading = false;

  Future <void> _submitAuthForm(String email, String password, String username, bool isLogin) async {
    
    AuthResult authResult;

    print(email);
    print(password);

    try {

      setState(() {
        _isLoading = true;
      });

      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(email: email,password: password);
        
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        await _store.collection('users').document(authResult.user.uid).setData({
          'username': username,
          'email': email
        });
      }

    } on PlatformException catch(err) {
      var message = "An error occured, please check your credentials";

      if (err.message != null) {
        message = err.message;
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), backgroundColor: Theme.of(context).errorColor));
    } catch(err) {
      print(err);
    }

    setState(() {
        _isLoading = false;
      });

    print(authResult);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: AuthForm(submitAuthForm: _submitAuthForm, isLoading: _isLoading)
    );
  }
}
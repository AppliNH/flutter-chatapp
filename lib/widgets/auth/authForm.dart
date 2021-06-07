import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm({Key key, this.submitAuthForm, this.isLoading}) : super(key: key);

  final Future<void> Function(String email, String password, String username, bool isLogin) submitAuthForm;
  final bool isLoading;
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {

  final _formKey = GlobalKey<FormState>();
  
  var _isLogin = true; // Controlls login mode or signup mode
  
  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';

  void _trySubmit() async {
    final isValid  = _formKey.currentState.validate();

    FocusScope.of(context).unfocus(); // Unfocus the textInput, so keyboard closes

    if (isValid) {
      _formKey.currentState.save(); // Triggers onSave for each TextInput
      
      await widget.submitAuthForm(_userEmail.trim(), _userPassword.trim(),_userName.trim(), _isLogin);

    }


  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
          margin: const EdgeInsets.all(20),
          child: widget.isLoading ? Padding( padding: EdgeInsets.all(20),child:CircularProgressIndicator()) : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min, // just takes as much height as needed
                  children: [
                    TextFormField(
                      key: ValueKey("email"),
                      validator: (v) {
                        if (v.isEmpty || !v.contains("@")) {
                          return 'Invalid Email';
                        }
                        return null;
                      },
                      onSaved: (v) {
                        _userEmail = v;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email address',
                      ),
                    ),
                    !_isLogin ? 
                      TextFormField(
                        key: ValueKey("username"),
                        validator: (v) {
                          if (v.isEmpty || v.length <4) {
                            return 'Username length must be at least 4';
                          }

                          return null;
                        },
                        onSaved: (v) {
                          _userName = v;
                        },
                        decoration: InputDecoration(
                          labelText: 'Username',
                        )
                      ) : Container(),
                    TextFormField(
                      key: ValueKey("password"),
                      validator: (v) {
                        if (v.isEmpty || v.length < 8) {
                          return 'Password length must be at least 8';
                        }
                        return null;
                      },
                      onSaved: (v) {
                        _userPassword = v;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                      )
                    ),
                    SizedBox(height: 12),
                    RaisedButton(child: Text(_isLogin ? "Login" : "Sign Up", style:TextStyle(color: Colors.white)), onPressed: _trySubmit),
                    FlatButton(child: Text(_isLogin ? "... or create a new account" :"I already have an account", style: TextStyle(decoration: TextDecoration.underline)),onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    })
                  ],
                ),
              ),
            )
          )
        ),
      );
  }
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gpproject/Pages/home.dart';

import 'login.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

//enum DataType {_email}

class _ResetPasswordState extends State<ResetPassword> {
  ScrollController _scrollController = new ScrollController();

  String _email;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
Color prime = Color(0xff0e243b);
  Color second = Colors.white ;
  Color third =  Color(0xff0ccaee) ;
  @override
  Widget build(BuildContext context) {
    return  new Scaffold(
      appBar: AppBar(
        title: Text(
          'إعادة تعين كلمة المرور',
          style: TextStyle(
            color: second,
            fontSize: 25.0,
          ),
        ),
        backgroundColor: prime,
        //leading: Icon(Icons.dehaze, size: 30.0, color: Colors.white),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          controller: _scrollController,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  top: 40.0, bottom: 0.0, right: 25.0, left: 20.0),
              child: TextFormField(
                validator: validateEmail,
                onSaved: (input) => _email = input,
                decoration: InputDecoration(
                  labelText: 'البريد الالكتروني',
                  icon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(
                    top: 0.0, bottom: 0.0, right: 50.0, left: 60.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SizedBox(
                      height: 30,
                      width: 80,
                    ),
                    ButtonTheme(
                      minWidth: 170,
                      child: RaisedButton(
                        padding: EdgeInsets.only(
                            top: 5, bottom: 5, right: 20, left: 20),
                        onPressed: resetPassword,
                        child: Text(
                          'إدخال',
                          style: TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal),
                        ),
                        color: third,
                        textColor:second,
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Email is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Invalid Email";
    } else {
      return null;
    }
  }

  Future<void> resetPassword() async {
    final FormState = _formKey.currentState;

    if (FormState.validate()) {
      FormState.save();
    }
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: _email);
      Navigator.push( context, MaterialPageRoute(builder: (context) => Login()));
    } catch (e) {
      print(e);
    }
  }
}
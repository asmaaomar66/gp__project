import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gpproject/Pages/home.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

//enum DataType {_email}

class _ResetPasswordState extends State<ResetPassword> {
   Color prime = Color(0xff0e243b);
  Color second = Colors.white ;
  Color third =  Color(0xff0ccaee) ;

  ScrollController _scrollController = new ScrollController();

  String _email;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
     // backgroundColor: prime,
      appBar: AppBar(
        title: Text(
          'إعادة تعين كلمة المرور',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25.0,
          ),
        ),
        backgroundColor: third,
        //leading: Icon(Icons.dehaze, size: 30.0, color: Colors.white),
      ),

      body: Form(
        key: _formKey,
        child: ListView(
          controller: _scrollController,
          children: <Widget>[
            
            Padding(
              padding: EdgeInsets.only( top: 120.0, bottom: 0.0, right: 25.0, left: 20.0),
              child: TextFormField(
                
                validator: (input){
                  if (input.isEmpty) {
                    return 'من فضلم ادخل البريد الالكتروني';
                  }
                },
                onSaved: (input) => _email = input,
                decoration: InputDecoration(
                  labelText: 'البريد الالكتروني',
                  icon: Icon(Icons.email , color: third,),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                cursorColor: third,
              ),
            ),

            Padding(
                padding: EdgeInsets.only(
                    top: 0.0, bottom: 0.0, right: 50.0, left: 60.0),
                child: Column( mainAxisSize: MainAxisSize.min,

                  children: <Widget>[
                    const SizedBox(
                      height: 30,
                      width: 80,
                    ),
                    ButtonTheme(
                     // minWidth: 170,
                      child: FloatingActionButton(
                       // padding: EdgeInsets.only( top: 5, bottom: 5, right: 20, left: 20),
                        onPressed: resetPassword,

                        child: Text( 'ادخال',
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal,
                              color: second
                              ),
                        ),
                        //color: Colors.cyan,
                        //textColor: Colors.white,
                        backgroundColor: third,

                      ),
                    ),
                  ],
                )
            ),
          ],
        ),
      ),
    );

  }
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> resetPassword() async {
    final FormState = _formKey.currentState;

    if (FormState.validate()){
      FormState.save();
    }
    try{
      await _firebaseAuth.sendPasswordResetEmail(email: _email);
      Navigator.push(context , MaterialPageRoute(builder: (context)=> MainPage()));
    }
    catch(e){
      print(e);
    }
  }
}
import 'package:gpproject/Auth/ResetPassword.dart';
import 'package:gpproject/Pages/AdminHome.dart';
import 'package:gpproject/Pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _Login();
  }
}

class _Login extends State<Login> {
  String _email;
  String _password;
  String msgStatus = '';
  ScrollController _scrollController = new ScrollController();
  final _formkey = GlobalKey<FormState>();
  bool _autoValidate = false;
  Color prime = Color(0xff0e243b);
  Color second = Colors.white ;
  Color third =  Color(0xff0ccaee) ;
  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
    onWillPop: () async => false,
    child:  new Scaffold(
      appBar: new AppBar(
        backgroundColor:prime,
        // Color.fromRGBO(1, 44, 45, 15),
        title: new Text(
          "الأفوكاتو",
          textDirection: TextDirection.rtl,
          style: TextStyle(
            color: Colors.white,
            fontSize: 21,
          ),
        ),
      ),
      body: new Form(
        key: _formkey,
        child : new ListView(
          controller: _scrollController,
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding:
                  EdgeInsets.only(left: 80, top: 60, right: 80, bottom: 40.0),
                  child: new Image.asset(
                    'image/11.png',
                    height: 170.0,
                    width: 170.0,
                  ),
                ),
              ],
            ),
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      left: 20, top: 0.0, right: 20, bottom: 20.0),
                  child: TextFormField(
                    validator: validateEmail,
                    keyboardType: TextInputType.emailAddress,
                    autofocus: true,
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      hintText: "البريد الإلكتروني",
                      contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                    ),
                    onSaved: (input) => _email = input,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 20, top: 0.0, right: 20, bottom: 10.0),
                  child: TextFormField(
                     validator: (input){
                      if (input.isEmpty) {
                        return 'من فضلك ادخل كلمة المرور';
                      }
                      if (input.length < 8) {
                        return 'يجب الا تقل كلمة المرور عن ثماني ارقام او احرف';
                      }
                    },
                    obscureText: true,
                    autofocus: true,
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      hintText: "كلمة السر",
                      contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 20.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                    ), 
                    onSaved: (input) => _password = input,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: new RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onPressed: signIn,
                    // padding: EdgeInsets.all(8),
                    color:third,
                    // Color.fromRGBO(1, 44, 45, 15),
                    child: Text('تسجيل الدخول',
                        style: TextStyle(color: Colors.white, fontSize: 22)),
                  ),
                ),
              new FlatButton(
                child: Text(
                  'هل نسيت كلمة المرور؟',
                  style: TextStyle(color: Colors.black , fontSize: 15.0),
                ),
                onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ResetPassword()));
                    },
              ),
              ],
            ),
          ],
        ),
      ) ,
      
   ) );
  }
  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "من فضلك ادخل البريد الالكتروني";
    } else if (!regExp.hasMatch(value)) {
      return "يجب ان يكون البريد الالكتروني متاح";
    } else {
      return null;
    }
  }
    void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("فشل في الادخال"),
          content: new Text("خطأ في البريد الالكتروني او كلمة المرور" , style: TextStyle(fontSize: 12 , color: Colors.red),),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("حسناً"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

Future<void> signIn()async{
      final FormState = _formkey.currentState;

      if (FormState.validate()){
        FormState.save();
        try{
          AuthResult user =  await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _email,
         password:_password ) ;
         if (_email == 'admin2020@gmail.com' && _password == '123456admin') {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> AdminHome()));

         }else{
          Navigator.push(context, MaterialPageRoute(builder: (context)=> MainPage(user:user.user)));
         }
        }
        catch(e){
          _showDialog();
          print(e.message);
        }
      }
       else{
      setState(() {
        _autoValidate = true;
      });
    }
    }
}

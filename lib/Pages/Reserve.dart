import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:gpproject/Pages/FreeTime.dart';
import 'package:gpproject/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
//import'package:saraah/data.dart';

import 'package:flutter/cupertino.dart';


class Reservation extends StatefulWidget {
  Reservation({Key key, this.title});
  final String title;
  @override
  _ReservationState createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {
  FocusNode myFocusNode = new FocusNode();
  List x = new List(3);
  List y = new List(2);
  String selectTime = "اختار ميعاد الحجز";
  TextEditingController _userName=new TextEditingController();
  TextEditingController _case=new TextEditingController();
  String day = "الثلاثاء 12/1";
  String time = "12 مساءا";
  Future _timeDialog() async {
    switch (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            contentPadding:
                EdgeInsets.only(top: 5, bottom: 20, right: 5, left: 5),
            backgroundColor: Colors.white,
            titlePadding: EdgeInsets.only(
              top: 5,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            title: Center(
                child: Column(
              children: <Widget>[
                Text(
                  "    المواعيد المتاحة ",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                      color: Color(0xffcb4154)),
                ),
                Text(
                  "للاستاذ : محمد عبد المعبود ",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                )
              ],
            )),
            children: x.map((x) {
              return Container(
                padding: EdgeInsets.only(bottom: 10),
                child: Row(
                  children: y.map((y) {
                    return GestureDetector(
                        onTap: () {
                          print("ontap called");
                          setState(() {
                            selectTime = day + " الساعة " + time;
                          });
                          Navigator.of(context).pop();
                        },
                        child: SizedBox(
                            width: 120.0,
                            height: 60.0,
                            child: Container(
                                padding:
                                    EdgeInsets.only(right: 5, top: 5, left: 5),
                                margin: EdgeInsets.only(right: 5.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xffb57281),
                                      Color(0xffb57281)
                                    ],
                                    begin: Alignment.centerRight,
                                    end: Alignment(-1.0, -1.0),
                                  ),
                                ),
                                child: Column(children: <Widget>[
                                  // Icon(Icons.calendar_today,color: Color(0xffe6a651),),
                                  Text("الثلاثاء 12/1",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w600)),
                                  Text("12:00 مساءا",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w600))
                                ]))));
                  }).toList(),
                ),
              );
            }).toList(),
          );
        })) {
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
            backgroundColor: Color(0xff314d4d),
           ),
        body: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("images/logo.jpg"),
                fit: BoxFit.cover,
              )),
            ),
            Center(
              child: Container(
                width: 500.0,
                height: 530.0,
                margin:
                    EdgeInsets.only(top: 80.0, right: 10, left: 15, bottom: 15),
                padding: EdgeInsets.only(
                    top: 20.0, left: 20.0, right: 20.0, bottom: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [Colors.white70, Colors.white70],
                    begin: Alignment.centerRight,
                    end: Alignment(-1.0, -1.0),
                  ),
                ),
                child: ListView(
                  children: <Widget>[
                    Center(
                      child: GradientText(
                        "حجز ميعاد",
                        gradient: LinearGradient(colors: [
                          Color(0xffb57281),
                          Color(0xff656255),
                          Color(0xff779ecb),
                          Color(0xff5a6457)
                        ]),
                        style: TextStyle(
                            fontSize: 40.0,
                            //  wordSpacing: 10,
                            // fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Amiri"),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Text(
                      '    اسم المدعي',
                      style: TextStyle(
                          color: Color(0xff620530),
                          // fontWeight: FontWeight.bold,
                          // fontStyle: FontStyle.italic,
                          textBaseline: TextBaseline.alphabetic),
                    ),
                    TextField(
                      obscureText: false,
                      controller: _userName,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                        hintText: "اسم صاحب المشكلة",
                        hintStyle: TextStyle(
                            color: myFocusNode.hasFocus
                                ? Colors.blue
                                : Colors.black),
                        fillColor: Colors.black54,
                        prefixIcon: Icon(Icons.account_circle,
                            color: Colors.blueGrey[900]),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Text(
                      '     تفاصيل المشكلة',
                      style: TextStyle(
                          color: Color(0xff620530),

                          // fontWeight: FontWeight.bold,
                          //fontStyle: FontStyle.italic,
                          textBaseline: TextBaseline.alphabetic),
                    ),
                    TextField(
                      maxLines: 2,
                      obscureText: false,
                       controller: _case,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        //labelText: "نبذة عن المشكلة ",
                        hintText: 'نبذة عن المشكلة ',
                        hintStyle: TextStyle(
                            color: myFocusNode.hasFocus
                                ? Colors.blue
                                : Colors.black),
                        fillColor: Colors.black54,
                        prefixIcon: Icon(Icons.description,
                            color: Colors.blueGrey[900]),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      '    موعد الحجز',
                      style: TextStyle(
                          color: Color(0xff620530),
                          // fontWeight: FontWeight.bold,
                          //fontStyle: FontStyle.italic,
                          textBaseline: TextBaseline.alphabetic),
                    ),
                    Container(
                        width: 100.0,
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(25.0),
                          color: Colors.white,
                        ),
                        child: SizedBox(
                          height: 25.0,
                          child: FlatButton(
                              onPressed: () => _timeDialog(),
                              color: Colors.white,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(selectTime),
                                  ),
                                  Icon(Icons.arrow_forward_ios)
                                ],
                              )),
                        )),
                    SizedBox(
                      height: 50.0,
                    ),
                    Container(
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            side: BorderSide(color: Color(0xff314d4d))),
                        onPressed: () {},
                        color: Color(0xff314d4d),
                        textColor: Colors.white,
                        child: Text("احجز الان",
                            style: TextStyle(
                              fontSize: 15.0,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
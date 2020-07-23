import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gpproject/Classes/notification.dart';
import 'package:gpproject/Classes/User.dart';
import 'drawerprofile.dart';
import 'package:firebase_auth/firebase_auth.dart';

class questionPage extends StatefulWidget {
   String id;
   FirebaseUser user;
   
  questionPage({Key key ,this.id, this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    
    return new questionPageState();
  }




}

class questionPageState extends State<questionPage> {
  Color prime = Color(0xff0e243b);
  Color second = Colors.white ;
  Color third =  Color(0xff0ccaee) ;
  NotificationClass notification = new NotificationClass();
  UserClass user = new UserClass();
  TextEditingController _controller = TextEditingController();
  var vab;
  var number ;
  var imp;
  var state = 'لم تتم الإجابة عن هذا السؤال بعد';
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
   notification.currentTime();
  // user.getCurrentUser();
    return new Scaffold(
                drawer: drawerprofile(currentUser: widget.user,),
                appBar: AppBar(title: new Text("سل" ),), 
                body: new Container(
                      padding: new EdgeInsets.all(10),
                      margin: new EdgeInsets.all(10),
               child: new ListView(
                       children: <Widget>[
                         new TextField(controller: _controller,
                                    maxLines:20 ,
                                      maxLength: 500,
                                      keyboardType: TextInputType.text,
                                      decoration: new InputDecoration(
                                        icon: new Icon(Icons.help,color: third),
                                      focusColor: third,
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                      hintText: 'أسال سؤالاً',
                                      hintStyle: TextStyle(
                                              color: third,
                                              fontSize: 18,
                                            ),
                                      fillColor: third,),
                                     ),
                        new Column( children: <Widget>[
                            new RaisedButton.icon(onPressed:() async {
                               final FirebaseUser user = await _auth.currentUser();
              DocumentReference ref = await Firestore.instance.collection('info').add(
                {"title": _controller.text, "lawyerid":widget.id});
                 imp = ref.documentID;
              Firestore.instance.collection("info").document(imp).updateData(
                {"Address": imp});
              Firestore.instance.collection("info").document(imp).updateData({"state": state});
              Firestore.instance.collection("reading").add({"title": _controller.text , "id": widget.id});
              Firestore.instance.collection("info").document(imp).updateData({ "userid": user.uid});
              Firestore.instance.collection("info").document(imp).updateData({"Date": notification.format});
               _controller.clear();},
                                            icon: new Icon(Icons.question_answer,
                                            color: Colors.white,),
                                            label:new Text('أسأل',style:TextStyle(color: Colors.white ,fontSize: 18.0),),
                                                                  color: third,
                                                    ),])],)
    ),);
}}


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gpproject/Pages/answerquestions.dart';
import 'drawerprofile.dart';

class QuestionList extends StatefulWidget {

final String value;
final FirebaseUser v ;
  QuestionList({Key key ,this.value, this.v}) : super(key: key);

  @override
  _QuestionList createState()=> new _QuestionList();
  }



  class _QuestionList extends State<QuestionList>{
    Color prime = Color(0xff0e243b);
  Color second = Colors.white ;
  Color third =  Color(0xff0ccaee) ;
  @override
  
Widget build(BuildContext context) {
 return StreamBuilder<QuerySnapshot>(
    stream: Firestore.instance.collection('info').where("lawyerid", isEqualTo: widget.value).orderBy("Date", descending: true)/*.orderBy("role", descending: true)*/.snapshots(),
    builder: (context, snapshot) {
        if (snapshot.hasData) {
            return Scaffold(
                drawer: drawerprofile(currentUser: widget.v,),
                appBar: AppBar(title: new Text("الاسئلة" ),),  
                body: new ListView(
                    children: snapshot.data.documents.map((doc) {
                      
                        return new Card(
                            color: Colors.white,
                            margin: EdgeInsets.only(
                               left: 3, right: 3.0, top: 5.0, bottom: 20.0),
                            child: ListTile( title: Text(doc.data['title'],
                            style: TextStyle(fontSize: 20,color: Colors.teal[900]),
                            textAlign: TextAlign.right,),
                            subtitle: Row( children: <Widget>[
                                          Container(child: Text(doc.data['state'], style: new TextStyle(color: third),),),
                                          Container(margin: EdgeInsets.only(right: 25.0),
                                                    child: Text(doc.data['Date'],
                                                    style: TextStyle(backgroundColor: Colors.blueGrey , color: Colors.white),
                                                           )),]),
                                                    onTap: (){ Navigator.of(context).push((MaterialPageRoute(builder: (context)=> AnswerQuestions(value: doc.data['title'], val: doc.data['Address'], v: widget.v, userid: doc.data['userid']))));},));
                               }).toList(),));}
        else {
              return SizedBox();
              }});

  }}
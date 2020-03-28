import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'drawerprofile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';



class QuestionAndAnswer extends StatefulWidget {
  final String value;
  FirebaseUser v ;
  QuestionAndAnswer({Key key ,this.value, this.v}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _QuestionAndAnswer();
  }




}

class _QuestionAndAnswer extends State<QuestionAndAnswer> {
 
 
  @override
  Widget build(BuildContext context) {

    return   StreamBuilder<QuerySnapshot>(
       stream:  Firestore.instance.collection('info').where("userid" , isEqualTo: widget.value ).
       where("state", isEqualTo: "     تمت الإجابة عن هذا السؤال   ").snapshots(),
       builder: (context, snapshot) {
           if (snapshot.hasData) {
                return
    
    new Scaffold(

 drawer: drawerprofile(currentUser: widget.v,),
                appBar: AppBar(title: new Text("افوكادو" ),),
       
        
      body: new ListView(
                   children: snapshot.data.documents.map((doc) {
                        return 

              new Card(

                  color: Colors.white,
                  margin: EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(top: 10, bottom: 10,),
                        child: Text(doc.data['title'],
                          //textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 20, color: Colors.black),),


                      ),
                      new Card(
    color: Colors.white,
    margin: EdgeInsets.only(
   left: 3, right: 3.0, top: 3.0, bottom: 10.0),
    child: new Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
    Padding(padding: EdgeInsets.only(top: 2, bottom: 7,),
    child:
   new Text(doc.data['answering'],
    //textDirection: TextDirection.rtl,
       textAlign: TextAlign.right,
    style: TextStyle(fontSize: 17, color: Colors.black54)),
  

    ),
    Text(doc.data['DateofAnswer'],
      style: TextStyle(fontSize: 17, color: Colors.white, backgroundColor: Colors.blueGrey),
        ),
  ] )),
      new Row(
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          IconButton(icon: new Icon(FontAwesomeIcons.solidHeart), alignment: Alignment.topRight,color: Colors.teal[900],onPressed: (){},),
          IconButton(icon: new Icon(FontAwesomeIcons.share), alignment: Alignment.topRight,color: Colors.teal[900],onPressed: (){},),
        ],
      ),

     
                      
    ],
                    


      ),

              
                      
            
                      );  }).toList(),
                      ));}
        else {
              return SizedBox();
              }});

  }}


           

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gpproject/Classes/User.dart';
import 'drawerprofile.dart';
import 'package:gpproject/Classes/notification.dart';
class AnswerQuestions extends StatefulWidget {
   final String value;
   final String val;
   FirebaseUser v ;
     

   final String userid;
  AnswerQuestions({Key key ,this.value, this.val, this.v, this.userid}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    
    return new _HomeState();
  }

}

class _HomeState extends State<AnswerQuestions> {
  UserClass user = new UserClass();
  TextEditingController _f = TextEditingController();
  var state =  "     تمت الإجابة عن هذا السؤال   ";
  NotificationClass notification = new NotificationClass();
  @override
  
  Widget build(BuildContext context) {
    notification.currentTime();
   // user.getCurrentUser();
    return Scaffold(
         drawer: drawerprofile(currentUser: widget.v,),
         appBar: AppBar(
                      title: new Text("اجب" ),
                       ),
         body: new ListView(
            children: <Widget>[Container(
            padding: new EdgeInsets.all(10),
            margin: new EdgeInsets.all(10),
                             child: new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
           new Text('${widget.value}',style: TextStyle(fontSize: 30,color: Colors.teal[900]),textAlign: TextAlign.right,),
           new TextField(controller: _f,
           maxLines:10 ,
           keyboardType: TextInputType.text,
           textDirection: TextDirection.rtl,
           textAlign: TextAlign.right,
           decoration: new InputDecoration(
                  focusColor: Colors.amber,
                  border: OutlineInputBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(10),bottom:Radius.circular(10) )),
                  hintText: 'الإجابهً',
                  fillColor: Colors.teal[900],

                                          ),
                        ),
             new Row(
                  children: <Widget>[
                            IconButton(
                              icon:Icon(
                                 Icons.add_photo_alternate),
                                      iconSize:50,
                                      color: Colors.grey[500],
                                     onPressed: (){}, ),

                            RaisedButton.icon(onPressed: () async {
              Firestore.instance.collection('info').document(widget.val).updateData({ "answering" : _f.text });
              Firestore.instance.collection('answers').add({"title": _f.text , "id": widget.userid});
              Firestore.instance.collection('info').document(widget.val).updateData({ "state" : state });
              Firestore.instance.collection('info').document(widget.val).updateData({"DateofAnswer": notification.format});              
              _f.clear();
                                                                  }, 
              icon:new Icon(Icons.arrow_forward_ios,color: Colors.white,),
              label:new Text('أجب',style:TextStyle(color: Colors.white),),
              color: Colors.teal[900],),
                           IconButton(icon:Icon(FontAwesomeIcons.twitter),iconSize:30, color: Colors.teal[900],onPressed: (){},),
                           IconButton(icon:Icon(FontAwesomeIcons.facebook),iconSize:30,color: Colors.teal[900],onPressed: (){},),
                                    ],
                     ),]))]));
}}



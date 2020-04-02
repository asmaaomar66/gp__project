import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gpproject/Pages/caseDetails.dart';
import 'package:gpproject/Pages/questionPage.dart';
import 'package:gpproject/models/cases.dart';
import 'drawerprofile.dart';
//import 'lawyerScreen.dart';
class  manageCases extends StatefulWidget {
final FirebaseUser currentCourt ;
  manageCases({Key key ,this.currentCourt}) : super(key: key);
 @override
  _manageCases createState()=> new _manageCases();
  }



  class _manageCases extends State<manageCases>{
      final a = Firestore.instance;
  Color prime = Color(0xff0e243b);
  Color second = Colors.white ;
  Color third =  Color(0xff0ccaee) ;
   @override
  Widget build(BuildContext context) {
    return
      StreamBuilder<QuerySnapshot>(
       stream:  a.collection('cases').where("courtId", isEqualTo: "${widget.currentCourt.uid}").snapshots(),
       builder: (context, snapshot) {
           if (snapshot.hasData) {
                return Scaffold(
                drawer: drawerprofile(currentUser: widget.currentCourt,),
                appBar: AppBar( 
                  backgroundColor: prime,
                  title:
                 new Text("ادارة القضايا الحاليه" ),),  
                body: new ListView(children: <Widget>[
          Column(
                   children: snapshot.data.documents.map((doc) {
                        return
                         
                          new Card(
                            color: Colors.white70,
                            margin: EdgeInsets.only(
                            left: 3, right: 3.0, top: 20.0, bottom: 5.0),
                            child: ListTile(title: Text(
                             'نوع القضيه : ${ doc.data['caseType']}',
                            style: TextStyle(fontSize: 25,color: third),
                            textAlign: TextAlign.right,),
                            subtitle: Column(children: <Widget>[ 
                              Row(
                                
                                children: <Widget>[
                                 Icon(
                                   Icons.arrow_right,
                                   color: prime,
                                   size: 30,
                                 ),
                                 Container(
                                child:Text(
                                  'حالة القضيه : ${doc.data['caseState']}',
                                  style: TextStyle(fontSize: 18
                                  ,color: prime,)
                                  ,textAlign: TextAlign.left,
                                ),),
                                ],
                              ),
                             Row(
                               children: <Widget>[
                               Icon(
                                   Icons.arrow_right,
                                   color: prime,
                                   size: 30,
                                 ),
                               Flexible(
                                child:Text(
                                  'الجريمة المرتكبه  : ${doc.data['crimeName']}',
                                  style: TextStyle(fontSize: 18
                                  ,color: prime,)
                                  ,textAlign: TextAlign.left,
                                ),)
                             ],)
                             ]),
                  onTap: 
                   (){
                     
                               Navigator.of(context).push((MaterialPageRoute(
                                 builder: (context)=>caseDetails(currentCase: doc, currentCourt : widget.currentCourt))));}
                            /*onTap: (){ Navigator.of(context).push((MaterialPageRoute(builder: (context)=> questionPage(id: doc.data['id'], user: widget.value ))));}*/,));
                                  }).toList(),)]));}
                    else {
                        return SizedBox();
                         }
                      });

  }}
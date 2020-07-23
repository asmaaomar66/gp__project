import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'caseDetails.dart';
import 'package:gpproject/Pages/drawerprofile.dart';
import 'package:toast/toast.dart';

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
    //---------------------------------- BODY OF CLASS ---------------------------------------------
    return WillPopScope(
      onWillPop: () async => false,
      child: new Scaffold(
      drawer: drawerprofile(currentUser: widget.currentCourt,),
      appBar: AppBar( 
         backgroundColor: prime,
         title:
          new Text("ادارة القضايا الحاليه" ),), 
      body:  StreamBuilder<QuerySnapshot>(
         stream:  a.collection('cases').where("courtId", isEqualTo: "${widget.currentCourt.uid}").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return new Container(
               padding: EdgeInsets.only(left: 5, right: 20, top: 10, bottom: 10.0),
               child: Column(children: <Widget>[
                 Expanded(
                   child: ListView(
                     children: snapshot.data.documents.map((DocumentSnapshot doc) {
                       return InkWell(
                         child: GestureDetector(
                           child: Container(
                              margin: EdgeInsets.only(
                              top: 10, right: 10, left: 10, bottom: 10),
                          height: 120,
                          width: 500,
                          decoration: BoxDecoration(
                              color: prime,
                              borderRadius: BorderRadius.circular(20.0),
                              boxShadow: [
                                BoxShadow(
                                    color: third,
                                    spreadRadius: 0.0,
                                    blurRadius: 7.0,
                                    offset: Offset(6, 7))
                              ]),
                              child: Column(children: <Widget>[
                                Expanded(
                                  flex: 1,
                                child: Container(
                                    height: 120,
                                    padding: EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20.0),
                                          bottomRight: Radius.circular(20.0)),
                                      color: prime,
                                    ),
                                    child: new Column(
                                      children: <Widget>[
                                         Text(
                                     "قضية رقم: ${doc.data['caseNumber']}",
                                    style: TextStyle(
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.w400,
                                      color: second,
                                    ),
                                  ),
                                   Text(
                                     'نوع القضيه : ${doc.data['caseType']}',
                                    style: TextStyle(
                                      fontSize: 21.0,
                                      fontWeight: FontWeight.w400,
                                      color: second,
                                    ),
                                  ),
                                  Text(
                                     'حالة القضيه : ${doc.data['caseState']}',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w400,
                                      color: second,
                                    ),
                                  ),
                                  
                                      ],
                                    ),
                                   )),
                                
                              ],),
                           ),
                      onTap: 
                   (){
                     var i_am = 'cases';
                               Navigator.of(context).push((MaterialPageRoute(
                                 builder: (context)=>
                                 caseDetails(currentCase: doc, currentCourt : widget.currentCourt,where_i_am: i_am,))));}
                         ),
                         
                       );
                     }).toList()
                   ,),
                 ),
               ],),
            );
            
          }
          else {
         return SizedBox();
             }
        } ,
        ),    
    )
  
,
    );
     
  }}
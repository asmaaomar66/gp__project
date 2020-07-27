import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gpproject/Classes/User.dart';
import 'package:gpproject/Pages/manage_rules.dart';
import 'package:toast/toast.dart';

import 'drawerprofile.dart';

class ruleDetails extends StatefulWidget{
  //----------------------Constractor---------
 ruleDetails({this.currentrule, this.user, this.id , this.collectionName});
    var currentrule;
    FirebaseUser user ;
    String id ;
    var collectionName;
  //---------------function-------------
  State<StatefulWidget> createState() {
    return new _ruleDetailsState();
    
  }
}

class _ruleDetailsState extends State<ruleDetails> {
  Color prime = Color(0xff0e243b);
  Color second = Colors.white ;
  Color third =  Color(0xff0ccaee) ;
  UserClass userClass = new UserClass();

List bnod = [] ;
var Selected ;
  @override
  Widget build(BuildContext context) {
     final databaseReference = Firestore.instance;
     var rulesRef = databaseReference.collection('Rules').document(widget.id).collection(widget.collectionName);
     return new Scaffold(
       drawer: drawerprofile(currentUser: widget.user),
       appBar: new AppBar(
                          title: Text(
                            '${widget.currentrule.data['Rolename']}',
                            style: TextStyle(
                              color: second,
                              fontSize: 25,
                            ),
                          ),
                          centerTitle: true,
                          backgroundColor: prime,
       ),
       body:  Container(
                padding:
                    EdgeInsets.only(left: 5, right: 20, top: 20, bottom: 20.0),
                child: Column(
                  children: <Widget>[
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                              left: 40, right: 30, top: 20, bottom: 20.0),
                          child: Center(
                              child: Text(
                            " رقم القانون : ${widget.currentrule.data['Rolenumber']} ",
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500,
                                color: third),
                          )),
                        ),
                        Text(
                          "نص القانون : ${widget.currentrule.data['Subjectname']} ",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            
                            Text(" البند : ${widget.currentrule.data['Bnod']} "),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                
                  SizedBox(
                              height: 10.0,
                            ),
                ]
                )
                )
      
         );
    

  }
  }
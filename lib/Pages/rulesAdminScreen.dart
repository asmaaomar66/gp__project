import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gpproject/Classes/User.dart';
import 'package:gpproject/Pages/manage_rules.dart';
import 'package:toast/toast.dart';

class rulescreen extends StatefulWidget{
  //----------------------Constractor---------
 rulescreen({this.currentrule, this.user, this.id});
    var currentrule;
    FirebaseUser user ;
    String id ;
  //---------------function-------------
  State<StatefulWidget> createState() {
    return new _rulescreenState();
    
  }
}

class _rulescreenState extends State<rulescreen> {
  Color prime = Color(0xff0e243b);
  Color second = Colors.white ;
  Color third =  Color(0xff0ccaee) ;
  UserClass userClass = new UserClass();



  @override
  Widget build(BuildContext context) {
    Firestore firebaseref = Firestore.instance;
    CollectionReference rulesRef = firebaseref.collection("Rules");
     return Scaffold(
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
                            Text(" البند : ${widget.currentrule.data['Bandname']} "),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new FloatingActionButton(
                          onPressed: (){
                            rulesRef
                            .document(widget.currentrule.documentID)
                            .delete()
                            .then((data) {
                            print("تم");
                           Toast.show("تم الحذف بنجاح", context);
                           Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return managerules();
                        }));

                        }).catchError((err) {
                          Toast.show("Err" + err.toString(), context);
                        });
                          },
                          backgroundColor: third,
                          child: new Text( "حذف",
                              style: TextStyle(
                                fontSize: 15.0,
                              ),),
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
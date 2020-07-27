import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gpproject/Classes/User.dart';
import 'package:gpproject/Pages/manage_courts.dart';
import 'package:toast/toast.dart';

import 'AdminHome.dart';

class courtscreen extends StatefulWidget{
  //----------------------Constractor---------
 courtscreen({this.currentcourt, this.user, this.id});
    var currentcourt;
    FirebaseUser user ;
    String id ;
  //---------------function-------------
  State<StatefulWidget> createState() {
    return new _courtscreenState();
    
  }
}

class _courtscreenState extends State<courtscreen> {
 Color prime = Color(0xff0e243b);
  Color second = Colors.white ;
  Color third =  Color(0xff0ccaee) ;
  UserClass userClass = new UserClass();

  @override
  Widget build(BuildContext context) {
    Firestore firebaseref = Firestore.instance;
    CollectionReference usersRef = firebaseref.collection("users");
     return new Scaffold(
       body:  Column(
             children: <Widget>[
                                   AppBar(
                                     title: Text(
                                       '${widget.currentcourt.data['username']}',
                            style: TextStyle(
                              color: second,
                              fontSize: 25,
                            ),
                          ),
                          centerTitle: true,
                          backgroundColor: prime,
                                   ),
                                  Padding(
                                        padding: EdgeInsets.only(
                                            top: 0.0, bottom: 10.0, right: 10.0, left: 10.0),
                                        child:   
                                   Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                 children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: 10.0),
                                  width: 100.0,
                                  height: 100.0,
                                  decoration: BoxDecoration(
                                    color: third,
                                    //image here
                                    image: DecorationImage(
                                              image: NetworkImage( '${widget.currentcourt.data['image']}'),
                                              fit: BoxFit.fill),
                                    borderRadius: BorderRadius.all(Radius.circular(75.0)),
                                  ),
                                )
                              ],
                            ),
                             ),
                             Padding(
                                        padding: EdgeInsets.only(
                                            top: 0.0, bottom: 10.0, right: 10.0, left: 10.0),
                                        child:  Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  //margin: EdgeInsets.all(5.0),
                                  child: new Text(
                                    widget.currentcourt.data['username'] ,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 25.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                                 ),
                                 new Card(
                                   color: Colors.white70,
                                    margin: EdgeInsets.only(
                                        left: 20.0, right: 20.0, top: 10, bottom: 0),
                                   child: new Column(
                                     children: <Widget>[
                                                 Container(
                              margin: EdgeInsets.only(right: 15.0, top: 7.0),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.perm_identity,
                                    color: third,
                                    size: 32.0,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 15.0),
                                    child: Text(
                                    '${widget.currentcourt.data['name']}',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                                  Container(
                              margin: EdgeInsets.only(right: 15.0, top: 7.0),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.phone,
                                    color: third,
                                    size: 32.0,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 15.0),
                                    child: Text(
                                    '${widget.currentcourt.data['email']}',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                      Container(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new FloatingActionButton(
                          onPressed: (){
                            usersRef
                            .document(widget.currentcourt.documentID)
                            .delete()
                            .then((data) {
                            print("تم");
                           Toast.show("تم الحذف بنجاح", context);
                           Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return managecourts();
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
                           /* Padding(
                              padding: EdgeInsets.only(top: 80.0),
                              child: new Center(
                                        child: new FloatingActionButton(
                                          tooltip: 'حذف',
                              backgroundColor: prime,
                               onPressed: () {
                                  print('تم الحذف بنجاح');
                                  Navigator.push( context,  MaterialPageRoute( builder: (context) => AdminHome()));
                                   this.userClass.deleteProfile(widget.currentcourt.documentID);
                               },
                            child: Icon(
                              Icons.delete_forever,
                              color: second,
                              size: 50.0,
                            ),
                            ),
                              ),
                            ),*/
                                     ],
                                   ),
                                 ),
                                 ],
                               ),
        
           );
    

  }
  }
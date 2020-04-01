import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gpproject/Classes/User.dart';
import 'package:gpproject/Pages/manage_lawyers.dart';
import 'package:toast/toast.dart';

class lawyerscreen extends StatefulWidget{
  //----------------------Constractor---------
 lawyerscreen({this.currentlawyer, this.user, this.id});
    var currentlawyer;
    FirebaseUser user ;
    String id ;
  //---------------function-------------
  State<StatefulWidget> createState() {
    return new _lawyerscreenState();
    
  }
}

class _lawyerscreenState extends State<lawyerscreen> {
 Color prime = Color(0xff0e243b);
  Color second = Colors.white ;
  Color third =  Color(0xff0ccaee) ;
  UserClass userClass = new UserClass();

  @override
  Widget build(BuildContext context) {
    Firestore firebaseref = Firestore.instance;
    CollectionReference usersRef = firebaseref.collection("users");
     return Scaffold(
       body:  Column(
             children: <Widget>[
                                   AppBar(
                                     title: Text(
                                       '${widget.currentlawyer.data['username']}',
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
                                              image: NetworkImage( '${widget.currentlawyer.data['image']}'),
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
                                    widget.currentlawyer.data['fname'] +' '+ widget.currentlawyer.data['lname'] ,
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
                                    '${widget.currentlawyer.data['username']}',
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
                                    Icons.phone_android,
                                    color: third,
                                    size: 32.0,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 15.0),
                                    child: Text(
                                    '${widget.currentlawyer.data['phone']}',
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
                                    Icons.mail,
                                    color: third,
                                    size: 32.0,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 15.0),
                                    child: Text(
                                     '${widget.currentlawyer.data['email']}',
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
                                    Icons.location_on,
                                    color: third,
                                    size: 32.0,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 15.0),
                                    child: Text(
                                     '${widget.currentlawyer.data['personaladdress']}',
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
                                    Icons.location_city,
                                    color: third,
                                    size: 32.0,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 15.0),
                                    child: Text(
                                     '${widget.currentlawyer.data['officeaddress']}',
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
                                     '${widget.currentlawyer.data['officenumber']}',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                      ),
                                    ),
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
                            usersRef
                            .document(widget.currentlawyer.documentID)
                            .delete()
                            .then((data) {
                            print("تم");
                           Toast.show("تم الحذف بنجاح", context);
                           Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return managelawyers();
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
                          /*  Padding(
                              padding: EdgeInsets.only(top: 80.0),
                              child: new Center(
                                        child: new FloatingActionButton(
                                          tooltip: 'حذف',
                              backgroundColor: prime,
                               onPressed: () {
                                  print('تم الحذف بنجاح');
                                  Navigator.push( context,  MaterialPageRoute( builder: (context) => managelawyers()));
                                   this.userClass.deleteProfile(widget.currentlawyer.documentID);
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
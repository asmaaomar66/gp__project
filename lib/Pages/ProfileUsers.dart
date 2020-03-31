import 'package:gpproject/Pages/drawerprofile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gpproject/Pages/profileEdit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

class profileUsers extends StatefulWidget {
  profileUsers({Key key  ,this.currentUser}) ;
  final FirebaseUser currentUser;

  @override
  profileUsersState createState() => profileUsersState();
}

class profileUsersState extends State<profileUsers>  {

  static Future<void> signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    FirebaseAuth.instance.signOut();
  }
  Color prime = Colors.red[800] ;
  Color second = Colors.white ;

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      drawer: drawerprofile(currentUser: widget.currentUser),
      body:  StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance
            .collection("users")
            .document(widget.currentUser.uid)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            return checkRole(snapshot.data);
          }
           return LinearProgressIndicator();
        },
      ),
    );
  }
 Widget checkRole(DocumentSnapshot snapshot) {
    if (snapshot.data == null) {
      return StreamBuilder<DocumentSnapshot>(
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text(" ...من فضلك انتظر قليلا"),
            );
          } else {
            return new Text('no data set in the userId document in firestore');
          }
        },
      );
    }
    if (snapshot.data['role'] == '1') {
      return userProfile(snapshot) ;
                } 
                else if (snapshot.data['role'] == '2') {
                  return lawyerProfile(snapshot);
                                  
                                  } else {
                                    return courtProfile(snapshot);
                                  }
                                }
                        
                          Widget userProfile(DocumentSnapshot snapshot) {
                            //final user = snapshot.data ;
                               return Column(
                                 children: <Widget>[
                                   AppBar(
                                     title: Text(
                                       '${snapshot.data['username']}',
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
                                    color: prime,
                                    //image here
                                    image: DecorationImage(
                                              image: NetworkImage( '${snapshot.data['image']}' ),
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
                                   '${snapshot.data['fname']}' + ' ' + '${snapshot.data['lname']}' ,
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
                                    color: Colors.grey,
                                    size: 32.0,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 15.0),
                                    child: Text(
                                     '${snapshot.data['username']}',
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
                                    color: Colors.grey,
                                    size: 32.0,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 15.0),
                                    child: Text(
                                     '${snapshot.data['phone']}',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 0.0, top: 7.0),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.mail,
                                    color: Colors.grey,
                                    size: 32.0,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 15.0),
                                    child: Text(
                                     '${snapshot.data['email']}',
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
                                    Icons.visibility,
                                    color: Colors.grey,
                                    size: 32.0,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 15.0),
                                    child: Text(
                                     '${snapshot.data['password']}',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 80.0),
                              child: new Center(
                                        child: new FloatingActionButton(
                                          tooltip: 'تعديل',
                                backgroundColor: prime,
                               onPressed: () {
                                  Navigator.push(context,MaterialPageRoute(builder: (context) => profileEdit(currentUser: widget.currentUser,)));
                               },
                            child: Icon(
                              Icons.edit,
                              color: second,
                              size: 50.0,
                            ),
                            
                            ),
                              ),
                            ),
                                     ],
                                   ),
                                 ),
                                 ],
                               );
                          }
                            Widget lawyerProfile(DocumentSnapshot snapshot) {
                            final user = snapshot.data ;
                               return ListView(
                                 children: <Widget>[
                                   AppBar(
                                     title: Text(
                                       '${snapshot.data['username']}',
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
                                    color: prime,
                                    //image here
                                    image: DecorationImage(
                                              image: NetworkImage( '${snapshot.data['image']}' ),
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
                                   '${snapshot.data['fname']}' + ' ' + '${snapshot.data['lname']}' ,
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
                                    color: Colors.grey,
                                    size: 32.0,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 15.0),
                                    child: Text(
                                     '${snapshot.data['username']}',
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
                                    color: Colors.grey,
                                    size: 32.0,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 15.0),
                                    child: Text(
                                     '${snapshot.data['phone']}',
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
                                    color: Colors.grey,
                                    size: 32.0,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 15.0),
                                    child: Text(
                                     '${snapshot.data['officenumber']}',
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
                                    color: Colors.grey,
                                    size: 32.0,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 15.0),
                                    child: Text(
                                     '${snapshot.data['email']}',
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
                                    Icons.visibility,
                                    color: Colors.grey,
                                    size: 32.0,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 15.0),
                                    child: Text(
                                     '${snapshot.data['password']}',
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
                                    color: Colors.grey,
                                    size: 32.0,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 15.0),
                                    child: Text(
                                     '${snapshot.data['personaladdress']}',
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
                                    color: Colors.grey,
                                    size: 32.0,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 15.0),
                                    child: Text(
                                     '${snapshot.data['officeaddress']}',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                             new FloatingActionButton(
                                          tooltip: 'تعديل',
                              backgroundColor: prime,
                               onPressed: () {
                                 Navigator.push(context,MaterialPageRoute(builder: (context) => profileEdit(currentUser: widget.currentUser,)));
                               },
                            child: Icon(
                              Icons.edit,
                              color: second,
                              size: 50.0,
                            ),
                            ),
                                     ],
                                   ),
                                 ),
                                 ],
                               );
                          }
                            Widget courtProfile(DocumentSnapshot snapshot) {
                            //final user = snapshot.data ;
                               return Column(
                                 children: <Widget>[
                                   AppBar(
                                     title: Text(
                                       '${snapshot.data['username']}',
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
                                    color: prime,
                                    //image here
                                    image: DecorationImage(
                                              image: NetworkImage( '${snapshot.data['image']}' ),
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
                                   '${snapshot.data['username']}' ,
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
                                    color: Colors.grey,
                                    size: 32.0,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 15.0),
                                    child: Text(
                                     '${snapshot.data['username']}',
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
                                    color: Colors.grey,
                                    size: 32.0,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 15.0),
                                    child: Text(
                                     '${snapshot.data['email']}',
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
                                    Icons.visibility,
                                    color: Colors.grey,
                                    size: 32.0,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 15.0),
                                    child: Text(
                                     '${snapshot.data['password']}',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 80.0),
                              child: new Center(
                                        child: new FloatingActionButton(
                                          tooltip: 'تعديل',
                              backgroundColor: prime,
                               onPressed: () {
                                 Navigator.push(context,MaterialPageRoute(builder: (context) => profileEdit(currentUser: widget.currentUser,)));
                               },
                            child: Icon(
                              Icons.edit,
                              color: second,
                              size: 50.0,
                            ),
                            ),
                              ),
                            ),
                                     ],
                                   ),
                                 ),
                                 ],
                               );
                          }
                  
                   

  }
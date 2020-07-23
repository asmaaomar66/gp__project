import 'package:gpproject/Pages/drawerprofile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gpproject/Pages/profileEdit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'HelloApp.dart';


class SettingsPage extends StatefulWidget {
  SettingsPage({Key key  ,this.currentUser}) ;
  final FirebaseUser currentUser;

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage>  {
  bool _dark;
    @override
  void initState() { 
    super.initState();
    _dark = false;
  }

  Brightness _getBrightness() {
     return _dark ? Brightness.dark : Brightness.light;
  }

  static Future<void> signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    FirebaseAuth.instance.signOut();
  }
  Color prime = Color(0xff0e243b);
  Color second = Colors.white ;
  Color third =  Color(0xff0ccaee) ;
  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade400,
    );
  }
  
  @override
  Widget build(BuildContext context) {
   
    return new WillPopScope(
    onWillPop: () async => false,
    child:new Scaffold(
     // backgroundColor: Colors.grey.shade200,
     appBar: AppBar(
                  elevation: 0,
                  backgroundColor: prime,
                 title: Text( 'الإعدادت',
                        style: TextStyle(color: Colors.white),
                            ),
                          ),
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
     ), );
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
      return usersetting(snapshot) ;
                } 
                else if (snapshot.data['role'] == '2') {
                  return lawyersetting(snapshot);
                                  
                                  } else {
                                    return courtsetting(snapshot);
                                  }
                                }
                        
                          Widget usersetting(DocumentSnapshot snapshot) {
                               return  Stack(
                                fit: StackFit.expand,
                                children: <Widget>[
                                  SingleChildScrollView(
                                    padding: const EdgeInsets.all(16.0),
                                    child:  Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                     Card(
                                    margin: const EdgeInsets.all(30.0),
                                    elevation: 8.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30.0)),
                                    color: Colors.grey.shade400,
                                    child:  Padding(
                                        padding: EdgeInsets.only(
                                            top: 0.0, bottom: 5.0, right: 5.0, left: 0.0),
                                        child:   
                                   Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                 children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: 5.0),
                                  width: 50.0,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    color: third,
                                    //image here
                                    image: DecorationImage(
                                              image: NetworkImage( '${snapshot.data['image']}' ),
                                              fit: BoxFit.fill),
                                    borderRadius: BorderRadius.all(Radius.circular(75.0)),
                                  ),
                                ),
                               Container(
                                  margin: EdgeInsets.only(right: 10.0),
                                  child: new Text(
                                    '${snapshot.data['fname']}' + ' ' + '${snapshot.data['lname']}'  ,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: second,
                                     fontSize: 16.0,
                                     fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ),
                                 Container(
                                  margin: EdgeInsets.only(right: 40.0 ),
                                  child: new IconButton(
                                    icon:Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ) ,
                                    onPressed: (){
                                      Navigator.push(context,MaterialPageRoute(builder: (context) => profileEdit(currentUser: widget.currentUser,)));
                                    },
                                  )
                                ),

                              ],
                            ),
                             ),
                                  ),
                  const SizedBox(height: 30.0),
                  Card(
                    elevation: 4.0,
                    margin: const EdgeInsets.fromLTRB(40.0, 8.0, 40.0, 16.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                         color: Colors.grey.shade200,
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(
                            Icons.lock_outline,
                            color:third,
                          ),
                          title: Text("تغير كلمة المرور"),
                          trailing: Icon(Icons.keyboard_arrow_left , color: third,),
                          onTap: () {
                            //open change password
                          },
                        ),
                       // _buildDivider(),
                       /* ListTile(
                          leading: Icon(
                            FontAwesomeIcons.language,
                            color: Colors.purple,
                          ),
                          title: Text("Change Language"),
                          trailing: Icon(Icons.keyboard_arrow_left),
                          onTap: () {
                            //open change language
                          },
                        ),*/
                        _buildDivider(),
                        ListTile(
                          leading: Icon(
                            Icons.email,
                            color: third,
                          ),
                          title: Text("تغير البريد الالكتروني"),
                          trailing: Icon(Icons.keyboard_arrow_left ,color: third,),
                          onTap: () {
                            //open change location
                          },
                        ),
                      ],
                    ),
                  ),
                 
                               ],
                             ),
                             ),
                              Positioned(
              bottom: -20,
              left: -20,
              child: Container(
                width: 80,
                height: 80,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color:  prime,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              bottom: 00,
              left: 00,
              child: IconButton(
                icon: Icon(
                  FontAwesomeIcons.powerOff,
                  color: Colors.white,
                ),
                onPressed: () {
                   signOut();
                   Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => HelloApp()));
                },
              ),
            )
                             ],

                             );
                          }
                            Widget lawyersetting(DocumentSnapshot snapshot) {
                                 return  Stack(
                                fit: StackFit.expand,
                                children: <Widget>[
                                  SingleChildScrollView(
                                    padding: const EdgeInsets.all(16.0),
                                    child:  Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                     Card(
                                    margin: const EdgeInsets.all(30.0),
                                    elevation: 8.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30.0)),
                                    color: Colors.grey.shade400,
                                    child:  Padding(
                                        padding: EdgeInsets.only(
                                            top: 0.0, bottom: 5.0, right: 5.0, left: 0.0),
                                        child:   
                                   Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                 children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: 5.0),
                                  width: 50.0,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    color: third,
                                    //image here
                                    image: DecorationImage(
                                              image: NetworkImage( '${snapshot.data['image']}' ),
                                              fit: BoxFit.fill),
                                    borderRadius: BorderRadius.all(Radius.circular(75.0)),
                                  ),
                                ),
                               Container(
                                  margin: EdgeInsets.only(right: 10.0),
                                  child: new Text(
                                    '${snapshot.data['fname']}' + ' ' + '${snapshot.data['lname']}' ,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: second,
                                     fontSize: 16.0,
                                     fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ),
                                 Container(
                                  margin: EdgeInsets.only(right: 40.0 ),
                                  child: new IconButton(
                                    icon:Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ) ,
                                    onPressed: (){
                                      Navigator.push(context,MaterialPageRoute(builder: (context) => profileEdit(currentUser: widget.currentUser,)));
                                    },
                                  )
                                ),

                              ],
                            ),
                             ),
                                  ),
                  const SizedBox(height: 30.0),
                  Card(
                    elevation: 4.0,
                    margin: const EdgeInsets.fromLTRB(40.0, 8.0, 40.0, 16.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                         color: Colors.grey.shade200,
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(
                            Icons.lock_outline,
                            color:third,
                          ),
                          title: Text("تغير كلمة المرور"),
                          trailing: Icon(Icons.keyboard_arrow_left , color: third,),
                          onTap: () {
                            //open change password
                          },
                        ),
                       // _buildDivider(),
                       /* ListTile(
                          leading: Icon(
                            FontAwesomeIcons.language,
                            color: Colors.purple,
                          ),
                          title: Text("Change Language"),
                          trailing: Icon(Icons.keyboard_arrow_left),
                          onTap: () {
                            //open change language
                          },
                        ),*/
                        _buildDivider(),
                        ListTile(
                          leading: Icon(
                            Icons.email,
                            color: third,
                          ),
                          title: Text("تغير البريد الالكتروني"),
                          trailing: Icon(Icons.keyboard_arrow_left ,color: third,),
                          onTap: () {
                            //open change location
                          },
                        ),
                      ],
                    ),
                  ),
                 
                               ],
                             ),
                             ),
                              Positioned(
              bottom: -20,
              left: -20,
              child: Container(
                width: 80,
                height: 80,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color:  prime,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              bottom: 00,
              left: 00,
              child: IconButton(
                icon: Icon(
                  FontAwesomeIcons.powerOff,
                  color: Colors.white,
                ),
                onPressed: () {
                   signOut();
                   Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => HelloApp()));
                },
              ),
            )
                             ],

                             );
                          }
                            Widget courtsetting(DocumentSnapshot snapshot) {
                               return  Stack(
                                fit: StackFit.expand,
                                children: <Widget>[
                                  SingleChildScrollView(
                                    padding: const EdgeInsets.all(16.0),
                                    child:  Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                     Card(
                                    margin: const EdgeInsets.all(30.0),
                                    elevation: 8.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30.0)),
                                    color: Colors.grey.shade400,
                                    child:  Padding(
                                        padding: EdgeInsets.only(
                                            top: 0.0, bottom: 5.0, right: 5.0, left: 0.0),
                                        child:   
                                   Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                 children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: 5.0),
                                  width: 50.0,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    color: third,
                                    //image here
                                    image: DecorationImage(
                                              image: NetworkImage( '${snapshot.data['image']}' ),
                                              fit: BoxFit.fill),
                                    borderRadius: BorderRadius.all(Radius.circular(75.0)),
                                  ),
                                ),
                               Container(
                                  margin: EdgeInsets.only(right: 30.0),
                                  child: new Text(
                                   '${snapshot.data['name']}'  ,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: second,
                                     fontSize: 16.0,
                                    ),
                                  ),
                                ),
                                 Container(
                                  margin: EdgeInsets.only(right: 80.0 ,left: 0.0),
                                  child: new IconButton(
                                    icon:Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ) ,
                                    onPressed: (){
                                      Navigator.push(context,MaterialPageRoute(builder: (context) => profileEdit(currentUser: widget.currentUser,)));
                                    },
                                  )
                                ),

                              ],
                            ),
                             ),
                                  ),
                  const SizedBox(height: 30.0),
                  Card(
                    elevation: 4.0,
                    margin: const EdgeInsets.fromLTRB(40.0, 8.0, 40.0, 16.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                         color: Colors.grey.shade200,
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(
                            Icons.lock_outline,
                            color:third,
                          ),
                          title: Text("تغير كلمة المرور"),
                          trailing: Icon(Icons.keyboard_arrow_left , color: third,),
                          onTap: () {
                            //open change password
                          },
                        ),
                       // _buildDivider(),
                       /* ListTile(
                          leading: Icon(
                            FontAwesomeIcons.language,
                            color: Colors.purple,
                          ),
                          title: Text("Change Language"),
                          trailing: Icon(Icons.keyboard_arrow_left),
                          onTap: () {
                            //open change language
                          },
                        ),*/
                        _buildDivider(),
                        ListTile(
                          leading: Icon(
                            Icons.email,
                            color: third,
                          ),
                          title: Text("تغير البريد الالكتروني"),
                          trailing: Icon(Icons.keyboard_arrow_left ,color: third,),
                          onTap: () {
                            //open change location
                          },
                        ),
                      ],
                    ),
                  ),
                 
                               ],
                             ),
                             ),
                              Positioned(
              bottom: -20,
              left: -20,
              child: Container(
                width: 80,
                height: 80,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color:  prime,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              bottom: 00,
              left: 00,
              child: IconButton(
                icon: Icon(
                  FontAwesomeIcons.powerOff,
                  color: Colors.white,
                ),
                onPressed: () {
                   signOut();
                   Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => HelloApp()));
                },
              ),
            )
                             ],

                             );
                          }
                  
                   

  }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gpproject/Auth/login.dart';
import 'package:gpproject/Pages/AdminHome.dart';
import 'package:gpproject/Pages/Rules.dart';
import 'package:gpproject/Pages/manage_courts.dart';
import 'package:gpproject/Pages/manage_rules.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'lawyersAdminScreen.dart';



class managelawyers extends StatefulWidget {
  @override
  _managelawyersState createState() => _managelawyersState();
}


class _managelawyersState extends State<managelawyers> {
  Color prime = Colors.red[800] ;
  Color second = Colors.white ;
  final snapshotusers = Firestore.instance;
  
   static Future<void> signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    FirebaseAuth.instance.signOut();
  }
  @override
  Widget build(BuildContext context) { 
    return  Scaffold(
 drawer: new Drawer(
                         child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              color: Theme.of(context).primaryColor,
              child: Center(
                child: Column(
                  children: <Widget>[
                     Container(
                      width: 100,
                      height: 100,
                    ),
                    Text('admin2020@gmail.com',
                        style: TextStyle(fontSize: 22, color:second)),
                    
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.supervised_user_circle,
                size: 25,
              ),
              title: Text(
                'إدارة_المستخدمين',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => AdminHome()));
              },
            ),
            ListTile(
              leading: Icon(Icons.markunread_mailbox),
              title: Text(
                'إدارة_المحاكم',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {
                 Navigator.push(context,MaterialPageRoute(builder: (context) => managecourts()));
              },
            ),
            ListTile(
              leading: Icon(Icons.warning),
              title: Text(
                'إدارة_القوانين',
                style: TextStyle(fontSize: 22 , ),
              ),
              onTap: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => Rules())); 
              },
            ),
             ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text(
                'تسجيل الخروج',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {
                signOut();
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
            ),
          ],
        ),
        ),
        appBar: AppBar(
          title: Text( 'إدارة_المُحامين',style: TextStyle(fontSize: 22), ),
           ),
           body:  StreamBuilder<QuerySnapshot>(
       stream:  snapshotusers.collection('users').where("role", isEqualTo: "2").snapshots(),
       builder: (context, snapshot) {
         if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            return new  Container(
             padding:
                    EdgeInsets.only(left: 5, right: 20, top: 10, bottom: 10.0),
            child:   Column(
                 children: <Widget>[
                   SizedBox(
                  height: 20,
                ),
                  Expanded(
                  child: ListView(
                    children:  snapshot.data.documents.map((doc) {
                      return GestureDetector(
                        child: Container(
                          margin: EdgeInsets.only(
                              top: 10, right: 10, left: 10, bottom: 10),
                          height: 120,
                          width: 500,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xff69a5a5),
                                    spreadRadius: 0.0,
                                    blurRadius: 13.0,
                                    offset: Offset(6, 7))
                              ]),
                          child: Row(children: <Widget>[
                            Expanded(
                                flex: 1,
                                child: Container(
                                    height: 120,
                                    padding: EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20.0),
                                          bottomRight: Radius.circular(20.0)),
                                      color: Color(0xff1bd0d0),
                                      image:  DecorationImage(
                                              image: NetworkImage( '${doc.data['image']}' ),
                                              fit: BoxFit.fill),
                                    ),
                                   )
                                   ),
                            Expanded(
                                flex: 3,
                                child: Container(
                                  padding: EdgeInsets.only(right: 10, left: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: Colors.white,
                                  ),
                                  child: Text(
                                    doc.data['fname']+" "+doc.data['lname'],
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                )
                                ),
                                 Expanded(
                                flex: 2,
                                child: Container(
                                  padding: EdgeInsets.only(right: 10, left: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: Colors.white,
                                  ),
                                  child: Text(
                                    doc.data['officenumber'],
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                )),
                                
                          ]),
                        ),
                        onTap: () async{
                         
                          Navigator.of(context).push((MaterialPageRoute( builder: (context)=> lawyerscreen(currentlawyer: doc , id: doc.data['id'] ))));
                        }
                      );
                    }).toList(),
                    
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
            ],
          ),
          );
           }
            return LinearProgressIndicator();
           }
           ),
    );
   
  }

}
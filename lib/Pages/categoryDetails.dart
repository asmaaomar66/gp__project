import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gpproject/Auth/login.dart';
import 'package:gpproject/Pages/AdminHome.dart';
import 'package:gpproject/Pages/EditRules.dart';
import 'package:gpproject/Pages/manage_courts.dart';
import 'package:gpproject/Pages/ruleDetails.dart';
import 'package:gpproject/Pages/rulesAdminScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:gpproject/models/roles.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HelloApp.dart';
import 'drawerprofile.dart';
import 'manage_lawyers.dart';



class categoryDetails extends StatefulWidget {
  categoryDetails({this.currentrule, this.user, this.id , this.collectionName});
    var currentrule;
    FirebaseUser user ;
    String id ;
    var collectionName;
  @override
  _categoryDetailsState createState() => _categoryDetailsState();
}


class _categoryDetailsState extends State<categoryDetails> {
 Color prime = Color(0xff0e243b);
  Color second = Colors.white ;
  Color third =  Color(0xff0ccaee) ;
  final snapshotusers = Firestore.instance;
  var CollectionName ;

   static Future<void> signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    FirebaseAuth.instance.signOut();
  }
  bool loading = false ;

  @override
  Widget build(BuildContext context) { 
    final databaseReference = Firestore.instance;
     var rulesRef = databaseReference.collection('Rules').document(widget.id).collection(widget.collectionName).getDocuments();
    return  new Scaffold(
     drawer: drawerprofile(currentUser: widget.user),
     appBar: AppBar(
                   title: Text(
                            '${widget.currentrule.data['name']}',
                            style: TextStyle(
                              color: second,
                              fontSize: 25,
                            ),
                          ),
                          centerTitle: true,           ),
      body: StreamBuilder<QuerySnapshot>(
                      stream:  Firestore.instance.collection('Rules').document(widget.id).collection(widget.collectionName).snapshots(),
                       builder: (context, snapshot) {
                           if(snapshot.hasError){
                             return Text("error");
                           }
                           if(snapshot.connectionState == ConnectionState.waiting){

                             return Center(child: SpinKitFadingCube(color: Colors.blueAccent,), heightFactor: 10,);
                           }
                        //if (snapshot.hasData ) {
                        else if (snapshot.hasData) {
                         return new  Container(
                      padding: EdgeInsets.only(left: 5, right: 20, top: 10, bottom: 10.0),
                      child:Column(
                      children: <Widget>[
                         Expanded(
                        child: ListView(
                         children:  snapshot.data.documents.map((DocumentSnapshot doc) {
                      return InkWell(
                        child: GestureDetector(
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
                                    color: third,
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
                                      color: prime,
                                    ),
                                    child: new Center(
                                      child: Text(
                                    doc.data['Rolename'],
                                    style: TextStyle(
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.w400,
                                      color: second,
                                    ),
                                  ),
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
                                   doc.data['Rolenumber'],
                                   
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                )),
                          ]),
                        ),
                        onTap: () async{
                         
                          Navigator.of(context).push((MaterialPageRoute( builder: (context)=> ruleDetails(currentrule: doc , id: doc.data['id']  , collectionName: CollectionName, user: widget.user,))));
                        }
                      ),
                      );
                    }).toList(),
                    
                  ),
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
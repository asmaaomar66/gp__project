import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gpproject/Pages/FreeTime.dart';
import 'package:gpproject/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'drawerprofile.dart';


class FreeTime extends StatefulWidget {
  final FirebaseUser currentUser;
  final String user;
  
FreeTime({Key key, this.currentUser, this.user}) : super(key: key);
  @override
 State<StatefulWidget> createState() {
    return new _FreeTime();
  }
}

class _FreeTime extends State<FreeTime> {
  Color prime = Color(0xff0e243b);
  Color second = Colors.white ;
  Color third =  Color(0xff0ccaee) ;
  
  @override
  Widget build(BuildContext context) {
  
    return  StreamBuilder<QuerySnapshot>(
      stream:  Firestore.instance.collection('Time').where("lawyerId" , isEqualTo: widget.user )
      .where("state", isEqualTo:true).orderBy('date').startAfter([DateTime.now()]).snapshots(),
      builder: (context, snapshot) {
         if (snapshot.hasData) {
            return new Scaffold(
      appBar: AppBar(
        title: new Text("افوكادو"),
         actions: <Widget>[
          FlatButton(onPressed: (){
            //Navigator.push(context, MaterialPageRoute(builder:(context)=>Test()));
          },child:Text('تم',style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),))
        ],
        backgroundColor: prime,),
        //drawer: drawerprofile(currentUser: widget.currentUser,),
        body: Container(
          child: ListView(
            children:snapshot.data.documents.map((doc) {
              //var t=DateTime.fromMillisecondsSinceEpoch(doc.data['date'],isUtc: true);
              var c=DateTime.parse(doc.data['date'].toDate().toString());
               var x=new DateFormat("yyy-MM-dd").format(c);
              return new Card(
        
         color: Colors.cyan[100],
        margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 2),
         
         child: Column(
           children: <Widget>[
             Row(children: <Widget>[
               SizedBox(width: 10,) ,
             new Icon(Icons.timer,color:Color(0xff314d4d)),
             new Text(" ${doc.data['time']} ",
             style: TextStyle(color: Colors.red,fontSize: 15,fontWeight: FontWeight.w700))
           ],),
          Row(
          children: <Widget>[
           //new Icon(Icons.date_range,color:Color(0xff314d4d),),
           new Text("  ${doc.data['day']}"+" $x " ,
           style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w700),),
    
         ],
       ),
       
       ]
             ));
            }).toList(),
          ),
        ),
        );
         }
         else{
           return SizedBox();
         }
      }
    );

  }
}
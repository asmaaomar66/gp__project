import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'caseDetails.dart';
import 'package:gpproject/Pages/drawerprofile.dart';

class  view_archived_cases extends StatefulWidget {
final FirebaseUser currentCourt ;
  view_archived_cases({Key key ,this.currentCourt}) : super(key: key);
 @override
  _view_archived_cases createState()=> new _view_archived_cases();
  }



  class _view_archived_cases extends State<view_archived_cases>{
      final a = Firestore.instance;

Color prime = Color(0xff0e243b);
  Color second = Colors.white ;
  Color third =  Color(0xff0ccaee) ;
   @override
     Widget build(BuildContext context) {
  //--------------------------------Body of Class ------------------------------
  return WillPopScope(
      onWillPop: () async => true,
      child: new Scaffold(

      drawer: drawerprofile(currentUser: widget.currentCourt,),
      appBar: AppBar( 
         backgroundColor: prime,
         title:
          new Text("أرشيف القضايا" ),), 
      body:  StreamBuilder<QuerySnapshot>(
         stream:  a.collection('archivedCases').where("courtId", isEqualTo: "${widget.currentCourt.uid}").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
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
                     var i_am = 'archived_cases';
                               Navigator.of(context).push((MaterialPageRoute(
                                 builder: (context)=>
                                 caseDetails
                                 (currentCase: doc, currentCourt : widget.currentCourt,where_i_am: i_am,))));}
                         ),
                         
                       );
                     }).toList()
                   ,),
                 ),
               ],),
            );
            
          }
        } ,
        ),    

    )
  

  );
     

  }
 /* Widget build(BuildContext context) {
    return
      StreamBuilder<QuerySnapshot>(
       stream:  a.collection('archivedCases').where("courtId", isEqualTo: "${widget.currentCourt.uid}").snapshots(),
       builder: (context, snapshot) {
           if (snapshot.hasData) {
                return Scaffold(
                drawer: drawerprofile(currentUser: widget.currentCourt,),
                appBar: AppBar( 
                  backgroundColor: prime,
                   //actions: <Widget>[ Icon(Icons.archive, size: 38,)],
                  title:
                 new Text(" أرشيف القضايا" , style: TextStyle(fontSize: 23) ,),
                
                 ),  
                body: new ListView(children: <Widget>[
          Column(
                   children: snapshot.data.documents.map((doc) {
                        return
                         
                          new Card(
                            color: Colors.white70,
                            margin: EdgeInsets.only(
                            left: 3, right: 3.0, top: 20.0, bottom: 5.0),
                            child: ListTile(title: Text(
                             'نوع القضيه : ${ doc.data['caseType']}',
                            style: TextStyle(fontSize: 25,color: third),
                            textAlign: TextAlign.right,),
                            subtitle: Column(children: <Widget>[ 
                              Row(
                                
                                children: <Widget>[
                                 Icon(
                                   Icons.arrow_right,
                                   color: prime,
                                   size: 30,
                                 ),
                                 Container(
                                child:Text(
                                  'حالة القضيه : ${doc.data['caseState']}',
                                  style: TextStyle(fontSize: 18
                                  ,color: prime)
                                  ,textAlign: TextAlign.left,
                                ),),
                                ],
                              ),
                             Row(
                               children: <Widget>[
                               Icon(
                                   Icons.arrow_right,
                                   color: prime,
                                   size: 30,
                                 ),
                               Flexible(
                                child:Text(
                                  'الجريمة المرتكبه  : ${doc.data['crimeName']}',
                                  style: TextStyle(fontSize: 18
                                  ,color: prime)
                                  ,textAlign: TextAlign.left,
                                ),)
                             ],)
                             ]),
                  onTap: 
                   (){
                     var i_am ='archived_cases';
                     Navigator.of(context).push((MaterialPageRoute(
                        builder: (context)=>
                        caseDetails(currentCase: doc, currentCourt : widget.currentCourt , where_i_am: i_am,))));}
                            /*onTap: (){ Navigator.of(context).push((MaterialPageRoute(builder: (context)=> questionPage(id: doc.data['id'], user: widget.value ))));}*/,));
                                  }).toList(),)]));}
                    else {
                        return SizedBox();
                         }
                      });

  }*/
  }
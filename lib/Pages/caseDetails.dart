import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'editCase.dart';
import 'package:toast/toast.dart';

import 'manageCases.dart';

class caseDetails extends StatefulWidget{

  caseDetails({this.currentCase , this.currentCourt , this.where_i_am});
  DocumentSnapshot currentCase;
  FirebaseUser currentCourt;
  var where_i_am ;
  @override
  State<StatefulWidget> createState() {
    return new _caseDetails();
  }

}

class _caseDetails extends State<caseDetails>{

 final FirebaseAuth _auth = FirebaseAuth.instance;

  //-----------------functions -------------------
  Widget _buildTwoButtons(){
    if (widget.where_i_am == 'cases') {
     return Container(
        padding: EdgeInsets.only(top: 20,left: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
             //------------------------ARCHIVE BUTTON----------------
             RaisedButton(
               shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              side: BorderSide(color: Color(0xffcb4154))),
                          onPressed: () {
                            onClickArchive();
                          },
                          color: Color(0xffcb4154),
                          textColor: Colors.white,
                          child: Row(
                            children:<Widget>[
                              Icon(
                                Icons.archive
                              ),
                              Text("ارشيف",
                              style: TextStyle(
                                fontSize: 15.0,
                              )),
                            ]
                          )
                        ),
                
                       
                          SizedBox(
                          width: 40.0,
                        ),
                        //---------------edit button----------------
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              side: BorderSide(color: Color(0xff69a5a5))),
                          onPressed: () {
                           
                               Navigator.of(context).push((MaterialPageRoute(
                                 builder: (context)=>
                                 editCase(currentCase: widget.currentCase,currentCourt: widget.currentCourt,) ) ) );
                          },
                          color: Color(0xff69a5a5),
                          textColor: Colors.white,
                          child:  Row(
                            children:<Widget>[
                              Icon(
                                Icons.edit
                              ),
                              Text("تعديل",
                              style: TextStyle(
                                fontSize: 15.0,
                              )),
                            ]
                          )
                        ),
                      ],
                    ),
                  );
 }
  else {
    return  SizedBox (height: 5,);
  }      
  }

  Future onClickArchive() async {
     final FirebaseUser user = await _auth.currentUser();
    Firestore _firestore = new Firestore();
    
  try{
    
      DocumentReference archivedCaseReff = Firestore.instance.collection('archivedCases').document();
      archivedCaseReff.setData({
          "caseId": archivedCaseReff.documentID,
          "courtId": user.uid,
          "caseType": widget.currentCase.data['caseType'],
          "caseState": widget.currentCase.data['caseState'],
          "victimName": widget.currentCase.data['victimName'],
          "offenderName": widget.currentCase.data['offenderName'],
          "crimeName": widget.currentCase.data['crimeName'],
          "caseDate": widget.currentCase.data['caseDate'],
          "caseNumber": widget.currentCase.data['caseNumber'],
    });

      CollectionReference casesReff = Firestore.instance.collection('cases');
      casesReff.document(widget.currentCase.data['caseId']).delete();
     Toast.show(" تم اضافة القضيه الي الارشيف بنجاح ", context,  duration: 3);
    Navigator.push(context,new MaterialPageRoute(
                          builder:(context)=>manageCases(currentCourt: widget.currentCourt,)
                      ));

  }
  catch(e){
    print(e);
  }
   
  
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
              backgroundColor: Color(0xff314d4d),
              title: Text("تفاصيل القضيه"),
              leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop()),
            ),
     body: Container(
                padding:
                    EdgeInsets.only(left: 5, right: 20, top: 20, bottom: 20.0),
                child: Column(children: <Widget>[
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                              left: 40, right: 30, top: 20, bottom: 20.0),
                          child: Center(
                              child: 
                               Text(
                            'قضية ${widget.currentCase.data['caseType']}',
                            style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.w500,
                                color: Color(0xffcb4154)),
                          )),
                        ),
                        Text(
                          "حالة القضيه : ${widget.currentCase.data['caseState']}",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          " الجاني : ${widget.currentCase.data['offenderName']}",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          " المجني عليه : ${widget.currentCase.data['victimName']}",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        
                        Text(
                          "الجريمه المرتكبه : ${widget.currentCase.data['crimeName']}",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                       Text(
                          " تاريخ القضيه : ${widget.currentCase.data['caseDate']}",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          " رقم القضيه التسلسلي : ${widget.currentCase.data['caseNumber']}",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        
                        //--------------------two buttons--------------------------
                      _buildTwoButtons(),
                                    ],
                    ),
                  ),
                         ])
 
       
     )
    );
  }
  

}
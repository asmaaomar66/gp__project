import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gpproject/Pages/editCase.dart';
import 'package:gpproject/models/cases.dart';

class caseDetails extends StatefulWidget{

  caseDetails({this.currentCase , this.currentCourt});
  DocumentSnapshot currentCase;
  FirebaseUser currentCourt;
  @override
  State<StatefulWidget> createState() {
    return new _caseDetails();
  }

}

class _caseDetails extends State<caseDetails>{
  Color prime = Color(0xff0e243b);
  Color second = Colors.white ;
  Color third =  Color(0xff0ccaee) ;
  //-----------------functions -------------------
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
              backgroundColor: prime,
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
                                color: third),
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
                        Container(
                    padding: EdgeInsets.only(top: 20,left: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              side: BorderSide(color: third)),
                          onPressed: () {},
                          color: third,
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
                              side: BorderSide(color: third)),
                          onPressed: () {
                           
                               Navigator.of(context).push((MaterialPageRoute(
                                 builder: (context)=>
                                 editCase(currentCase: widget.currentCase,currentCourt: widget.currentCourt,) ) ) );
                          },
                          color: third,
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
                  ),
         
                      ],
                    ),
                  ),
                         ])
 
       
     )
    );
  }
  

}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'caseDetails.dart';
import 'package:gpproject/Pages/home.dart';
//import 'package:gpproject/Pages/lawyerquestions.dart';
import 'manageCases.dart';
import 'package:gpproject/Pages/questionPage.dart';
import 'package:toast/toast.dart';

class editCase extends StatefulWidget{

  editCase({this.currentCase , this.currentCourt});
  FirebaseUser currentCourt;
  var currentCase;
  @override
  State<StatefulWidget> createState() {
    return new _editCase();
  }

}

class _editCase extends State<editCase>{
  //-----------------------variables------------------
 
   TextEditingController  caseType = new TextEditingController();
   TextEditingController caseState = new TextEditingController();
   TextEditingController victimName = new TextEditingController();
   TextEditingController offenderName = new TextEditingController();
   TextEditingController crimeName = new TextEditingController();
   TextEditingController caseNumber = new TextEditingController();
   TextEditingController caseDate = new TextEditingController();

   //---------------------------function----------------
   onClickEditCase(){
   
      Firestore firebaseref = Firestore.instance;
    CollectionReference casesReff = firebaseref.collection("cases");
         casesReff.document(widget.currentCase.data['caseId']).updateData({
           "caseType": caseType.text,
            "caseState": caseState.text,
              "victimName": victimName.text,
              "offenderName": offenderName.text,
               "crimeName": crimeName.text,
               "caseDate": caseDate.text,
                 "caseNumber": caseNumber.text
   }).then((data) {
                        Toast.show("تم تعديل القضيه بنجاح", context, duration: 3);
                       Navigator.push(context,new MaterialPageRoute(
                          builder:(context)=>manageCases(currentCourt: widget.currentCourt,)
                      ));
                      }).catchError((err) {
                        print(err);
                        Toast.show("Error :" + err.toString(), context,duration: 3);
                      });
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
              backgroundColor: Color(0xff314d4d),
              title: Text("تعديل القضيه"),
              leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop()),
            ),
                body:new Padding(
        padding:EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
        child: ListView(
          children: <Widget>[
            new Center(
              child: new Text(
                  "تعديل علي قضيه رقم  ${widget.currentCase.data['caseNumber']} " ,
                  style: TextStyle(
                      color: Color(0xff314d4d),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,

                      ),
                ),
            ),
            SizedBox(
              height: 25.0,
            ),
            //------------------EDIT CASE TYPE---------------------
                 Text(
                      " نوع القضيه : ${widget.currentCase.data['caseType']}",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                 new Row(
                   
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                    new Expanded(
                        child: 
                        TextFormField(
                          keyboardType: TextInputType.text,
                          autofocus: true,
                          // onSaved: (input) => _rulename = input,
                          controller: caseType,
                          textDirection: TextDirection.rtl,
                          decoration: InputDecoration( 
                            hintText: "ادخل نوع القضيه", 
                            hintStyle: TextStyle(
                              fontSize: 18,
                            ),
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                        ),
                  ),
                      ],
                    ),
                    SizedBox( height: 30,),
            //------------------EDIT CASESTATE-----------------
                   Text(
                      " حالة القضيه : ${widget.currentCase.data['caseState']}",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                             Expanded(
                    child: Container(
                     
                      child: new
                       TextFormField(
                          keyboardType: TextInputType.text,
                          autofocus: true,
                         // onSaved: (input) => _rulenumber = input,
                          controller: caseState,
                          textDirection: TextDirection.rtl,
                          decoration: InputDecoration( 
                            hintText: "ادخل حالة القضيه", 
                            hintStyle: TextStyle(
                              fontSize: 18,
                            ),
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                           ),
                    ),
                  ),
                    ],
                  ),
                      SizedBox( height: 30,),
                  //--------------------------EDIT VICTIM NAME --------------------
                    Text(
                      "  اسم المجني عليه  : ${widget.currentCase.data['victimName']}",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),              
                    new Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                    child: Container(
                     
                      child: new
                        TextFormField(
                          keyboardType: TextInputType.text,
                          autofocus: true,
                           //onSaved: (input) => _subjectname = input,
                          controller: victimName,
                          textDirection: TextDirection.rtl,
                          decoration: InputDecoration( 
                            hintText: "ادخل اسم المجني عليه", 
                            hintStyle: TextStyle(
                              fontSize: 18,
                            ),
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                         ),  
                    ),
                  ),
                    ],
                 ),
                   SizedBox( height: 30,),
                 //------------------------- EDIT OFFENDER NAME-------------------
                 Text(
                      "  اسم الجاني   : ${widget.currentCase.data['offenderName']}",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),              
                    new Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                    child: Container(
                     
                      child: new
                        TextFormField(
                          keyboardType: TextInputType.text,
                          autofocus: true,
                           //onSaved: (input) => _subjectname = input,
                          controller: offenderName,
                          textDirection: TextDirection.rtl,
                          decoration: InputDecoration( 
                            hintText: "ادخل اسم الجاني ", 
                            hintStyle: TextStyle(
                              fontSize: 18,
                            ),
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                         ),  
                    ),
                  ),
                    ],
                 ),
                    SizedBox( height: 30,),
                 //------------------------- EDIT CRIME NAME----------------------
                 Text(
                      " الجريمة المرتكبه : ${widget.currentCase.data['crimeName']}",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),              
                    new Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                    child: Container(
                      
                      child: new
                        TextFormField(
                          keyboardType: TextInputType.text,
                          autofocus: true,
                           //onSaved: (input) => _subjectname = input,
                          controller: crimeName,
                          textDirection: TextDirection.rtl,
                          decoration: InputDecoration( 
                            hintText: "ادخل اسم الجريمه المرتكبه", 
                            hintStyle: TextStyle(
                              fontSize: 18,
                            ),
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                         ),  
                    ),
                  ),
                    ],
                 ),
                      SizedBox( height: 30,),
                 //------------------------- EDIT CASE DATE ----------------------
                 Text(
                      " تاريخ القضيه : ${widget.currentCase.data['caseDate']}",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),              
                    new Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                    child: Container(
                    
                      child: new
                        TextFormField(
                          keyboardType: TextInputType.text,
                          autofocus: true,
                           //onSaved: (input) => _subjectname = input,
                          controller: caseDate,
                          textDirection: TextDirection.rtl,
                          decoration: InputDecoration( 
                            hintText: "ادخل تاريخ القضيه  ", 
                            hintStyle: TextStyle(
                              fontSize: 18,
                            ),
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                         ),  
                    ),
                  ),
                    ],
                 ),
                 SizedBox( height: 30,),
                 //------------------------- EDIT CASE NUMBER---------------------
                 Text(
                      " رقم القضيه التسلسلي : ${widget.currentCase.data['caseNumber']}",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),              
                    new Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                    child: Container(
                     
                      child: new
                        TextFormField(
                          keyboardType: TextInputType.text,
                          autofocus: true,
                           //onSaved: (input) => _subjectname = input,
                          controller: caseNumber,
                          textDirection: TextDirection.rtl,
                          decoration: InputDecoration( 
                            hintText: "ادخل رقم القضيه التسلسلي", 
                            hintStyle: TextStyle(
                              fontSize: 18,
                            ),
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                         ),  
                    ),
                  ),
                    ],
                 ),
                 SizedBox( height: 30,),
                 //---------------------------OK BUTTON-------------------
                 Container(
                  width: double.infinity,
                  child: FloatingActionButton(
                    backgroundColor: Color(0xff314d4d),
                    child: Text("تعديل"),
                    onPressed: () {
                      onClickEditCase();
                                 },
                  ),
                ),
                SizedBox(
                  height: 10,
                  )
        ],
        ),
      ),
      );
  }

}
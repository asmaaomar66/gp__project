
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gpproject/Pages/rulesAdminScreen.dart';
import 'caseDetails.dart';
import 'package:gpproject/Pages/home.dart';
//import 'package:gpproject/Pages/lawyerquestions.dart';
import 'manageCases.dart';
import 'package:gpproject/Pages/questionPage.dart';
import 'package:toast/toast.dart';

class editrule extends StatefulWidget{

  editrule({this.currentrule , this.id , this.collectionName});
  var currentrule;
  var id;
  var collectionName;
  //var varToShow;
  @override
  State<StatefulWidget> createState() {
    return new _editrule();
  }

}

class _editrule extends State<editrule>{
  Color prime = Color(0xff0e243b);
  Color second = Colors.white ;
  Color third =  Color(0xff0ccaee) ;
  //-----------------------variables------------------
 
   TextEditingController  bnod = new TextEditingController();
   TextEditingController rolename = new TextEditingController();
   TextEditingController rolenumber = new TextEditingController();
   TextEditingController subjectname = new TextEditingController();
  


  /* TextEditingController  bnod0 ;
  List <String> bnod= List<String>();
   List<TextEditingController> _bands=new List<TextEditingController> ();*/

   //---------------------------function----------------
   onClickEditCase(){
   
     final databaseReference = Firestore.instance;
     var rulesRef = databaseReference.collection('Rules').document(widget.id).collection(widget.collectionName);
         rulesRef.document(widget.currentrule.data['id']).updateData({
           "Bnod": bnod.text,
            "Rolename": rolename.text,
              "Rolenumber": rolenumber.text,
              "Subjectname": subjectname.text,
            
   }).then((data) {
                        Toast.show("تم تعديل القضيه بنجاح", context, duration: 3);
                       Navigator.push(context,new MaterialPageRoute(
                          builder:(context)=>rulescreen(currentrule: widget.currentrule , id: widget.id  , collectionName: widget.collectionName,)
                      ));
                      }).catchError((err) {
                        print(err);
                        Toast.show("Error :" + err.toString(), context,duration: 3);
                      });
   }
  @override
  Widget build(BuildContext context) {

//-----------------------------------Body of Class---------------------------------
return WillPopScope(
  onWillPop: () async => false,
  child: Scaffold(
       appBar: AppBar(
              backgroundColor: prime,
              title: Text("تعديل القانون"),
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
                  "تعديل علي القانون  ${widget.currentrule.data['Rolename']} " ,
                  style: TextStyle(
                      color: prime,
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
                      " بند القانون : ${widget.currentrule.data['Bnod']}",
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
                          controller: bnod,
                          textDirection: TextDirection.rtl,
                          decoration: InputDecoration( 
                            hintText: "ادخل بند القانون", 
                            hintStyle: TextStyle(
                              color: third,
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
                      " اسم القانون : ${widget.currentrule.data['Rolename']}",
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
                          controller: rolename,
                          textDirection: TextDirection.rtl,
                          decoration: InputDecoration( 
                            hintText: "ادخل اسم القانون", 
                            hintStyle: TextStyle(
                              color: third,
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
                      "  ادخل رقم القانون  : ${widget.currentrule.data['Rolenumber']}",
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
                          keyboardType: TextInputType.number,
                          autofocus: true,
                           //onSaved: (input) => _subjectname = input,
                          controller: rolenumber,
                          textDirection: TextDirection.rtl,
                          decoration: InputDecoration( 
                            hintText: "ادخل رقم القانون ", 
                            hintStyle: TextStyle(
                              color: third,
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
                      "  نص القانون   : ${widget.currentrule.data['Subjectname']}",
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
                          controller: subjectname,
                          textDirection: TextDirection.rtl,
                          decoration: InputDecoration( 
                            hintText: "ادخل نص القانون ", 
                            hintStyle: TextStyle(
                              color: third,
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
                
                 SizedBox( height: 30,),
                 //---------------------------OK BUTTON-------------------
                 Container(
                  width: double.infinity,
                  child: FloatingActionButton(
                    backgroundColor: third,
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
      )
  ,
);
      }

}
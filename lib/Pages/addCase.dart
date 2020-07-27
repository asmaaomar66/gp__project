import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'manageCases.dart';
import 'package:gpproject/Pages/questionPage.dart';
import 'package:toast/toast.dart';
import 'package:gpproject/Pages/drawerprofile.dart';

class addCase extends StatefulWidget {
  addCase({this.currentCourt});
    var currentCourt;
  @override
  State<StatefulWidget> createState() {
    return new _StateAddCase();
  }

} 

class _StateAddCase extends State<addCase>{
//-----------------------VARIABLES----------------------------
 final FirebaseAuth _auth = FirebaseAuth.instance;
final _formKey = GlobalKey<FormState>();
ScrollController _scrollController = new ScrollController();
  String    _caseType ,_caseState , _victimName , _offenderName ,_crimeName ,_caseDate ,_caseNumber; 
   TextEditingController caseType = new TextEditingController();
   TextEditingController caseState = new TextEditingController();
   TextEditingController victimName = new TextEditingController();
   TextEditingController offenderName = new TextEditingController();
   TextEditingController crimeName = new TextEditingController();
   TextEditingController caseDate = new TextEditingController();
   TextEditingController caseNumber = new TextEditingController();
  
  //-------------------------------functions-----------------

  void addNewCase () async{
   final FirebaseUser user = await _auth.currentUser();
    Firestore _firestore = new Firestore();
    
  try{
    
      DocumentReference documentReference = Firestore.instance.collection('cases').document();
      documentReference.setData({
          "caseId": documentReference.documentID,
          "courtId": user.uid,
          "caseType": caseType.text,
          "caseState": caseState.text,
          "victimName": victimName.text,
          "offenderName": offenderName.text,
          "crimeName": crimeName.text,
          "caseDate": caseDate.text,
          "caseNumber": caseNumber.text,
    });
     Toast.show("تم اضافة القضيه بنجاح", context,  duration: 3);
    Navigator.push(context,new MaterialPageRoute(
                          builder:(context)=>manageCases(currentCourt: widget.currentCourt,)
                      ));

  }
  catch(e){
    print(e);
  }
   
  
}
Color prime = Color(0xff0e243b);
  Color second = Colors.white ;
  Color third =  Color(0xff0ccaee) ;
  
  @override
  Widget build(BuildContext context) {
//-------------------------------Body of Class-----------------------------
return WillPopScope(
  onWillPop: () async => false,
  child:   Scaffold( 
        drawer: drawerprofile(currentUser: widget.currentCourt,),
                appBar: AppBar(title: new Text("اضافة قضيه جديده" ),),
                  //-----------------------take inputs---------------------- 
               body: new Form(
                 key: _formKey,
                 child: ListView(
                   controller: _scrollController,
                    children: <Widget>[
                   SizedBox(height: 20,),
                  
                //---------------case type----------------
                Text(
                      " نوع القضيه ",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20.0,0,20,20),
                  child: new Column(
                    children: <Widget>[
                              TextFormField(
                      
                          keyboardType: TextInputType.text,
                          autofocus: true,
                           onSaved: (input) => _caseType = input,
                          controller: caseType,
                          textDirection: TextDirection.rtl,
                          decoration: InputDecoration( 
                            hintText: "نوع القضيه", 
                            hintStyle: TextStyle(
                              color: third,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                           validator: (input) {
                             assert(input != null);
                           if (input.isEmpty) {
                        return 'ãä ÝÖáß ÇÏÎá ÇÓã ÇáÞÇäæä';  }},
                        ),
                         SizedBox(height: 20,),
                         //-----------------------case state -------------------
                          Text(
                          " حالة القضيه  ",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                            textDirection: TextDirection.rtl,
                            ),
                         TextFormField(
                          keyboardType: TextInputType.text,
                          autofocus: true,
                           onSaved: (input) => _caseState = input,
                          controller: caseState,
                          textDirection: TextDirection.rtl,
                          decoration: InputDecoration( 
                            hintText: "حالة القضيه", 
                            hintStyle: TextStyle(
                              color: third,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                           validator: (input) {
                             assert(input != null);
                           if (input.isEmpty) {
                        return 'ãä ÝÖáß ÇÏÎá ÇÓã ÇáÞÇäæä';  }},
                        ),
                         SizedBox(height: 20,),
                         //-----------------------victim name -------------------
                           Text(
                          "اسم المجني عليه ",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                            textDirection: TextDirection.rtl,
                            ),
                         TextFormField(
                          keyboardType: TextInputType.text,
                          autofocus: true,
                           onSaved: (input) => _victimName = input,
                          controller: victimName,
                          textDirection: TextDirection.rtl,
                          decoration: InputDecoration( 
                            hintText: "اسم المجني عليه", 
                            hintStyle: TextStyle(
                              color: third,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                           validator: (input) {
                           if (input.isEmpty) {
                        return 'ãä ÝÖáß ÇÏÎá ÇÓã ÇáÞÇäæä';  }},
                        ),
                         SizedBox(height: 20,),
                         //-----------------------offender name -------------------
                         Text(
                           "اسم الجاني",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                            textDirection: TextDirection.rtl,
                            ),
                         TextFormField(
                          keyboardType: TextInputType.text,
                          autofocus: true,
                           onSaved: (input) => _offenderName = input,
                          controller: offenderName,
                          textDirection: TextDirection.rtl,
                          decoration: InputDecoration( 
                            hintText: "اسم الجاني", 
                            hintStyle: TextStyle(
                              color: third,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                           validator: (input) {
                           if (input.isEmpty) {
                        return 'ãä ÝÖáß ÇÏÎá ÇÓã ÇáÞÇäæä';  }},
                        ),
                        SizedBox(height: 20,),
                         //-----------------------الجريمة المرتكبه -------------------
                          Text(
                           "الجريمة المرتكبه",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                            textDirection: TextDirection.rtl,
                            ),
                         TextFormField(
                          keyboardType: TextInputType.text,
                          autofocus: true,
                           onSaved: (input) => _crimeName = input,
                          controller: crimeName,
                          textDirection: TextDirection.rtl,
                          decoration: InputDecoration( 
                            hintText: "الجريمة المرتكبه", 
                            hintStyle: TextStyle(
                              color: third,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                           validator: (input) {
                           if (input.isEmpty) {
                        return 'ãä ÝÖáß ÇÏÎá ÇÓã ÇáÞÇäæä';  }},
                        ),
                        SizedBox(height: 20,),
                        //------------------ case date--------------
                         Text(
                          "تاريخ القضيه",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                            textDirection: TextDirection.rtl,
                            ),
                         TextFormField(
                          keyboardType: TextInputType.datetime,
                          autofocus: true,
                           onSaved: (input) => _caseDate = input,
                          controller: caseDate,
                          textDirection: TextDirection.rtl,
                          decoration: InputDecoration( 
                            hintText: "تاريخ القضيه", 
                            hintStyle: TextStyle(
                              color: third,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                           validator: (input) {
                           if (input.isEmpty) {
                        return 'ãä ÝÖáß ÇÏÎá ÇÓã ÇáÞÇäæä';  }},
                        ),
                         SizedBox(height: 20,),
                         //-----------------case number--------------------------
                          Text(
                          "تسلسل القضيه",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                            textDirection: TextDirection.rtl,
                            ),
                    TextFormField(
                          keyboardType: TextInputType.number,
                          autofocus: true,
                          onSaved: (input) => _caseNumber = input,
                          controller: caseNumber,
                          textDirection: TextDirection.rtl,
                          decoration: InputDecoration( 
                            hintText: "تسلسل القضيه", 
                            hintStyle: TextStyle(
                              color: third,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                           validator: (input) {
                           if (input.isEmpty) {
                        return 'ãä ÝÖáß ÇÏÎá ÑÞã ÇáãÇÏÉ';  }},
                        ),
                         SizedBox(height: 20,),
                         //-------------------- add button------------------------
                      new FloatingActionButton(
                       // shape:new RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),), 
                        backgroundColor: third,
                       // color: Colors.grey, 
                        //textColor: Colors.white, 
                        child: new Text("اضافه ", 
                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0)
                        ), 

                        onPressed: () {
                               if(_formKey.currentState.validate()){
                                 addNewCase();
                               }

                               else {
                                  Toast.show("ادخل جميع البيانات", context,  duration: 3);
                               }
                                     }, 
                        splashColor: Colors.lightBlueAccent,
                        ),
                    ],
                  ),
                ),
                   

 
                                       ],),
          
                 ),
               
                 )

,
);
       }

}
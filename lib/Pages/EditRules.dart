import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gpproject/Classes/User.dart';
import 'package:gpproject/Pages/manage_rules.dart';
import 'package:gpproject/models/roles.dart';
import 'package:toast/toast.dart';

class editroles extends StatefulWidget{
  //----------------------Constractor---------
 //editroles({this.currentrule});
    var currentrule;
   
  editroles(rule) {
    currentrule = rule;
  }
    //String id ;
  //---------------function-------------
  State<StatefulWidget> createState() {
    return new _editrolesState(currentrule);
    
  }
}

class _editrolesState extends State<editroles> {
  Color prime = Colors.red[800] ;
  Color second = Colors.white ;
  UserClass userClass = new UserClass();
  Role _role = new Role();
   final _formKey = GlobalKey<FormState>();
   ScrollController _scrollController = new ScrollController();
   final snapshotusers = Firestore.instance;
    TextEditingController  ruleName = new TextEditingController();
   TextEditingController ruleNum = new TextEditingController();
   TextEditingController ruleContext = new TextEditingController();
   TextEditingController bnod = new TextEditingController();
     _editrolesState(rule) {
    _role = rule;
    //gamename = curGame.name;
    //hours = curGame.hours.toString();
    ruleName.text = _role.rolename;
    ruleNum.text = _role.rolenumber;
    ruleContext.text = _role.subjectname;
     bnod.text = _role.bandname;
  }
  @override
  Widget build(BuildContext context) {
    Firestore firebaseref = Firestore.instance;
    CollectionReference rulesRef = firebaseref.collection("Rules");
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: prime,
        title: Text(
         _role.rolename,
          style: TextStyle(
            color: second,
          ),
        ),
        actions: <Widget>[
          new Icon(Icons.edit),
        ],
      ),
     
      body:new Padding(
        padding:EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
        child: ListView(
          children: <Widget>[
            new Center(
              child: new Text(
                  "تعديل " + _role.rolename,
                  style: TextStyle(
                      color: Colors.purple,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,

                      ),
                ),
            ),
            SizedBox(
              height: 10.0,
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
                          controller: ruleName,
                          textDirection: TextDirection.rtl,
                          decoration: InputDecoration( 
                            hintText: "إدخل اسم القانون", 
                            hintStyle: TextStyle(
                              fontSize: 18,
                            ),
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                          /* validator: (input) {
                           if (input.isEmpty) {
                        return 'من فضلك ادخل اسم القانون';  }},*/
                        ),
                  ),
                      ],
                    ),
                      new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                             Expanded(
                    child: Container(
                      margin: EdgeInsets.all(10),
                     // margin: EdgeInsets.fromLTRB(0.0, 00.0, 25.0, 0),
                      child: new
                       TextFormField(
                          keyboardType: TextInputType.number,
                          autofocus: true,
                         // onSaved: (input) => _rulenumber = input,
                          controller: ruleNum,
                          textDirection: TextDirection.rtl,
                          decoration: InputDecoration( 
                            hintText: "إدخل رقم المادة", 
                            hintStyle: TextStyle(
                              fontSize: 18,
                            ),
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                         /*  validator: (input) {
                           if (input.isEmpty) {
                        return 'من فضلك ادخل رقم المادة';  }},*/
                        ),
                    ),
                  ),
                    ],
                  ),
                    new Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      //margin: EdgeInsets.fromLTRB(0.0, 00.0, 25.0, 0),
                      child: new
                        TextFormField(
                          keyboardType: TextInputType.text,
                          autofocus: true,
                           //onSaved: (input) => _subjectname = input,
                          controller: ruleContext,
                          textDirection: TextDirection.rtl,
                          decoration: InputDecoration( 
                            hintText: "إدخل نص المادة", 
                            hintStyle: TextStyle(
                              fontSize: 18,
                            ),
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                          /* validator: (input) {
                           if (input.isEmpty) {
                        return 'من فضلك ادخل نص المادة';  }},*/
                        ),  
                    ),
                  ),
                    ],
                 ),
                   new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                            Expanded(
                    child: Container(
                      margin: EdgeInsets.all(10),
                     // margin: EdgeInsets.fromLTRB(0.0, 00.0, 25.0, 0),
                      child: new
                       TextFormField(
                          keyboardType: TextInputType.text,
                          autofocus: false,
                          // onSaved: (input) => _bandname = input,
                          maxLines:5,                    
                          controller: bnod,
                          //textDirection: TextDirection.rtl,
                          decoration: InputDecoration(  
                            hintText: "البند", 
                            hintStyle: TextStyle(
                              fontSize: 18,
                            ),         
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                          /* validator: (input) {
                           if (input.isEmpty) {
                        return 'من فضلك ادخل  البند';  }},*/
                        ),
                    ),
                  ),
                    ],
                  ),
                    Container(
                  width: double.infinity,
                  child: FloatingActionButton(
                    backgroundColor: prime,
                   // color: Colors.blue,
                   // textColor: Colors.white,
                    child: Text("تعديل"),
                    onPressed: () {
                     print(_role.rId);
                      rulesRef.document(_role.rId).updateData({
                        "Rolename": ruleName.text,
                        "Rolenumber": ruleNum.text,
                        "Subjectname": ruleContext.text,
                        "Bandname": bnod.text,
                      }).then((data) {
                        print("تم");
                        // print(data);
                        Toast.show("تم التعديل بنجاح", context);
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return managerules();
                        }));
                      }).catchError((err) {
                        print(err);
                        Toast.show("Error :" + err.toString(), context);
                      });
                    },
                  ),
                ),
        ],
        ),
      ),
    );
  }
  }
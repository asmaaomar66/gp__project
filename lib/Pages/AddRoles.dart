import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gpproject/Auth/login.dart';
import 'package:gpproject/Pages/manage_rules.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Rules.dart';
import 'manage_courts.dart';
import 'manage_lawyers.dart';


class AddRoles extends StatefulWidget {
  @override
  _AddRolesState createState() => _AddRolesState();
}

class _AddRolesState extends State<AddRoles> {

 
 String  _rulename, _subjectname , _bandname , _rulenumber ; 
   TextEditingController  ruleName ;
  TextEditingController ruleNum ;
  TextEditingController   ruleContext ;
  TextEditingController  bnod ;
  List<String> rulename = List<String>(),
   subjectname = List<String>() ,  bandname = List<String>(),  rulenumber = List<String>();
  Map<String, String> _formdata = {};
  var _myPets = List<Widget>();
  int _index = 1;
  final Firestore _firestore = Firestore.instance;
  void add(){
    bnod = new TextEditingController();
    int keyValue = _index;
    _myPets = List.from(_myPets)
      ..add(
        Column(
          key: Key("${keyValue}"),
          children: <Widget>[
            Padding(
             // padding: EdgeInsets.symmetric(vertical: 50.0,horizontal: 20.0),
              padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 10.0),
              child: new Column(
                children: <Widget>[
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
                           onSaved: (input) => _bandname = input,
                          maxLines:5,                    
                          controller: bnod,
                          //textDirection: TextDirection.rtl,
                          decoration: InputDecoration(  
                            hintText: "البند", 
                            hintStyle: TextStyle(
                              color: third,
                              fontSize: 18,
                            ),         
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                           validator: (input) {
                           if (input.isEmpty) {
                        return 'من فضلك ادخل  البند';  }},
                        ),
                    ),
                  ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    setState(() {
      _index++;
    });
  }
  void _add() {
    ruleName = new TextEditingController();
    ruleNum = new TextEditingController();
    ruleContext = new TextEditingController();
    bnod = new TextEditingController();
    int keyValue = _index;
    _myPets = List.from(_myPets)
      ..add(
        Column(
          key: Key("${keyValue}"),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 50.0,horizontal: 20.0),
              //padding: const EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 10.0),
              child: new Column(
                children: <Widget>[
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                    new Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          autofocus: true,
                           onSaved: (input) => _rulename = input,
                          controller: ruleName,
                          textDirection: TextDirection.rtl,
                          decoration: InputDecoration( 
                            hintText: "إدخل اسم القانون", 
                            hintStyle: TextStyle(
                              color: third,
                              fontSize: 18,
                            ),
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                           validator: (input) {
                           if (input.isEmpty) {
                        return 'من فضلك ادخل اسم القانون';  }},
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
                          onSaved: (input) => _rulenumber = input,
                          controller: ruleNum,
                          textDirection: TextDirection.rtl,
                          decoration: InputDecoration( 
                            hintText: "إدخل رقم المادة", 
                            hintStyle: TextStyle(
                              color: third,
                              fontSize: 18,
                            ),
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                           validator: (input) {
                           if (input.isEmpty) {
                        return 'من فضلك ادخل رقم المادة';  }},
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
                           onSaved: (input) => _subjectname = input,
                          controller: ruleContext,
                          textDirection: TextDirection.rtl,
                          decoration: InputDecoration( 
                            hintText: "إدخل نص المادة", 
                            hintStyle: TextStyle(
                              color: third,
                              fontSize: 18,
                            ),
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                           validator: (input) {
                           if (input.isEmpty) {
                        return 'من فضلك ادخل نص المادة';  }},
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
                           onSaved: (input) => _bandname = input,
                          maxLines:5,                    
                          controller: bnod,
                          //textDirection: TextDirection.rtl,
                          decoration: InputDecoration(  
                            hintText: "البند", 
                            hintStyle: TextStyle(
                              color: third,
                              fontSize: 18,
                            ),         
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                           validator: (input) {
                           if (input.isEmpty) {
                        return 'من فضلك ادخل  البند';  }},
                        ),
                    ),
                  ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    setState(() {
      _index++;
    });
  }


  @override
  void initState() {
    // TODO: implement
    super.initState();
    _add();
  }

 void submitData() async{
  final Firestore _firestore = Firestore.instance;
  try {
       DocumentReference documentReference = Firestore.instance.collection('Rules').document();
      documentReference.setData(
          {  'id': documentReference.documentID,
            'Rolename': ruleName.text, 
            'Rolenumber': ruleNum.text,
            'Subjectname': ruleContext.text, 
            'Bandname': bnod.text, 
            'role': 'rule',
            
            });
    } catch (e) {
      print(e);
    }
}
Color prime = Color(0xff0e243b);
  Color second = Colors.white ;
  Color third =  Color(0xff0ccaee) ;
  static Future<void> signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                color: third,
              ),
              title: Text(
                'إدارة_المُحامين',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => managelawyers()));
              },
            ),
            ListTile(
              leading: Icon(Icons.markunread_mailbox ,color: third,),
              title: Text(
                'إدارة_المحاكم',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => managecourts()));
              },
            ),
            ListTile(
              leading: Icon(Icons.warning ,color: third,),
              title: Text(
                'إدارة_القوانين',
                style: TextStyle(fontSize: 22 , ),
              ),
              onTap: () {
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => managerules()));
              },
            ),
             /*ListTile(
              leading: Icon(Icons.exit_to_app , color: third,),
              title: Text(
                'تسجيل الخروج',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {
                signOut();
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
            ),*/
          ],
        ),
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          rulename.add(ruleName.text);
          rulenumber.add(ruleNum.text);
          subjectname.add(ruleContext.text);
          bandname.add(bnod.text);
          //print(food);
          //print(qtn);
          submitData();
           Navigator.push( context, MaterialPageRoute(builder: (context) => managerules()));
        },
        backgroundColor: third,
        child: Text('إضافة'),
      ),
      appBar: AppBar(
        title: Text(
          'إضافة قانون',
          style: TextStyle(fontSize: 30, color: second),
        ),
        backgroundColor: prime,
        actions: <Widget>[
          IconButton(
            icon: new Icon(Icons.add),
            onPressed: () {
        /*rulename.add(ruleName.text);
          rulenumber.add(ruleNum.text);
          subjectname.add(ruleContext.text);*/
          bandname.add(bnod.text);
              print(bandname);
              add();
            },
            iconSize: 30,
            color: second,
          ),
        ],
      ),
      body: ListView(
        children: _myPets,
      ),
    );
  }

  
}
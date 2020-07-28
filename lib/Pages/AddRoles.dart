import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gpproject/Auth/login.dart';
import 'package:gpproject/Pages/manage_rules.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import 'Rules.dart';
import 'manage_courts.dart';
import 'manage_lawyers.dart';


class AddRoles extends StatefulWidget {
  @override
  _AddRolesState createState() => _AddRolesState();
}

class _AddRolesState extends State<AddRoles> {

 final _formKey=GlobalKey<FormState>();

   TextEditingController  ruleName ;
  TextEditingController ruleNum ;
  TextEditingController   ruleContext ;
  var collectionName;
  var documentId;
  TextEditingController  bnod0 ;
  List <String> bnod= List<String>();

  var _myPets = List<Widget>();
  int _index = 1;
  List<TextEditingController> _bands=new List<TextEditingController> ();
  int counter=0;
  final Firestore _firestore = Firestore.instance;
  //----------------------------------------------------------------
   List allSections=[];
 var selected="اختار القسم";
  Future _dialogCase() async {
    switch (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return
           StreamBuilder<QuerySnapshot>  (
     
     stream: Firestore.instance.collection('Rules').snapshots(),
      builder: (context, snapshot) {
         if (snapshot.hasData) {
            allSections=snapshot.data.documents;
        
      if(allSections.isNotEmpty){
        return  SimpleDialog(
             contentPadding:  EdgeInsets.only(top: 5, bottom: 20, right: 5, left: 5),
            backgroundColor: Colors.white,
            titlePadding: EdgeInsets.only(
              top: 5,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
             title:  Container(
              height: MediaQuery.of(context).size.height/3,
              width: 300, child : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                children:allSections.map((group){
                   return GestureDetector(
                    child: Text(group['name']),
                    onTap: (){
                      setState(() {
                       selected= group['name'];
                     collectionName= group['name'];
                     documentId=group["id"];
                      });
                      Navigator.pop(context);
                        print(selected);
                    },
                   )
                   ;

                }).toList(),
              ),
               ))  );
              }
              else{
        return SimpleDialog(
             contentPadding:
                EdgeInsets.only(top: 5, bottom: 20, right: 5, left: 5),
            backgroundColor: Colors.white,
            titlePadding: EdgeInsets.only(
              top: 5,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
             title: 
            Container(
               margin: EdgeInsets.only(
                            left: 10, right: 3.0, top: 3.0, bottom: 10.0),
              child:Center(
                 child: Text(
                 "من فضلك انتظر.... ",
                 
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                     color:Color(0xff0ccaee)),
                ),
               )
            )
                   
                   );
      }
          }
         else{
           return  SimpleDialog(
             contentPadding:
                EdgeInsets.only(top: 5, bottom: 20, right: 5, left: 5),
            backgroundColor: Colors.white,
            titlePadding: EdgeInsets.only(
              top: 5,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
             title: 
             Center(
                child: 
                Text(
                 "من فضلك انتظر قليلا ....",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                      color: Color(0xffcb4154)),
                ),
                
                
                )
                
                );
                
            
         }
              
              }
              );
              }))
              {

              }
              }
              
  //-------------------------------------------------------------
  void add()async{
    setState(() {
      counter++;
    });
    bnod0 = new TextEditingController();
    TextEditingController _band1=new TextEditingController();
  
    int keyValue = _index;
    _myPets = List.from(_myPets)
      ..add(
        Form(child: Column(
          key: Key("${keyValue}"),
          children: <Widget>[
           
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                            Expanded(
                    child: Container(
                      margin: EdgeInsets.all(10),
                   
                      child: new
                       TextFormField(
                          keyboardType: TextInputType.text,
                          autofocus: false,
                    
                          maxLines:5,                    
                          controller: _band1,
                      
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
        ),)
      );
    setState(() {
      _index++;
      _bands.add(_band1);
    });
  }
  void _add() async{
    ruleName = new TextEditingController();
    ruleNum = new TextEditingController();
    ruleContext = new TextEditingController();
    bnod0 = new TextEditingController();
    //_bands=new List<TextEditingController> (10);
    int keyValue = _index;
    _myPets = List.from(_myPets)
      ..add(
      Form(
        key: _formKey,
        child:   Column(
          key: Key("${keyValue}"),
          children: <Widget>[
           
                  
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                    new Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          autofocus: true,
                   
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
                   
                      child: new
                       TextFormField(
                          keyboardType: TextInputType.number,
                          autofocus: true,
                          //onSaved: (input) => _rulenumber = input,
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
                        return 'من فضلك ادخل رقم المادة';  }
                        return null;},
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
                         //  onSaved: (input) => _subjectname = input,
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
                        return 'من فضلك ادخل نص المادة';  }
                        return null;
                        },
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
                    
                      child: new
                       TextFormField(
                          keyboardType: TextInputType.text,
                          autofocus: false,
                          // onSaved: (input) => _bandname = input,
                          maxLines:5,                    
                          controller: bnod0,
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
                        return 'من فضلك ادخل البند';
                      }
                      
                      return null;
                    },
                        ),
                    ),
                  ),
                    ],
                  )
                ,
          ],
        ),)
      );
    setState(() {
      _index++;
      _bands.add(bnod0);
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
       DocumentReference documentReference = Firestore.instance.collection('Rules').document("$documentId"). collection("$collectionName").document();
       documentReference.setData({
          'id': documentReference.documentID,
            'Rolename': ruleName.text, 
            'Rolenumber': ruleNum.text,
            'Subjectname': ruleContext.text, 
            'Bnod':bnod, 
            'role': 'rule',
       });
       Toast.show("تم الادخال بنجاح", context);
       Navigator.push(context,  MaterialPageRoute( builder: (context) => managerules()));
    
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
  

    return new WillPopScope(
    onWillPop: () async => false,
    child:new Scaffold(
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
                Navigator.push(context,MaterialPageRoute(builder: (context) => managelawyers()));
              },
            ),
            ListTile(
              leading: Icon(Icons.markunread_mailbox ,color: third,),
              title: Text(
                'إدارة_المحاكم',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => managecourts()));
              },
            ),
            ListTile(
              leading: Icon(Icons.warning ,color: third,),
              title: Text(
                'إدارة_القوانين',
                style: TextStyle(fontSize: 22 , ),
              ),
              onTap: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => managerules()));
              },
            ),
            
          ],
        ),
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
       
           if(_formKey.currentState.validate()){
              for(int i=0;i<_bands.length;i++){
                if(_bands[i].text.isNotEmpty){
                   bnod.add(_bands[i].text);

                }
               
              }
              
            }
            submitData();
            print("$bnod");
       /* 
           Navigator.push( context, MaterialPageRoute(builder: (context) => managerules()));*/
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
    
              add();
            
            },
            iconSize: 30,
            color: second,
          ),
        ],
      ),
      body: Padding( 
         padding: EdgeInsets.symmetric(vertical: 50.0,horizontal: 20.0),
      child:ListView(
        children:<Widget>[
          Container(
                        width: 300.0,
                       
                        margin: EdgeInsets.only(bottom:25.0,left:5,right: 5),
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width:3,color:prime)),
                          
                          color: Colors.white,
                        ),
                        child: SizedBox(
                          height: 40.0,
                          child: FlatButton(
                              onPressed: () {
                               _dialogCase();

                              },
                              color: Colors.white,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text("$selected",style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                                    ),),
                                  ),
                                  Icon(Icons.arrow_forward_ios)
                                ],
                              )),
                        )),
              Column(
        children: _myPets,
      ),
        ]
      ))
    ), 
    );
  }

  
}


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'editCase.dart';
import 'package:toast/toast.dart';
import 'package:gpproject/main.dart';
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
  Color prime = Color(0xff0e243b);
  Color second = Colors.white ;
  Color third =  Color(0xff0ccaee) ;

  TextEditingController  inputData = new TextEditingController();

 final FirebaseAuth _auth = FirebaseAuth.instance;

//-------------------------------------BEGIN OF FUNCTIONS ---------------------------------
  Widget _whereIShowEditButton(num flag){
    if (widget.where_i_am == 'cases'){
      return Container(
        width: 90,
        height: 30,
        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              side: BorderSide(color:third)),
                          onPressed: () {
                                  _onClickEditButton(flag);        
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
        
      )  ;
    }
    else{
      return SizedBox();
    }
    }
 
  Widget _buildSeparator(Size screenSize, BuildContext context){
    return Container(
      width: screenSize.width / 1.2,
      height: 2.0,
      color: prime,
      margin: EdgeInsets.only(top: 10.0),
    );
  }
 
  Widget _whereIShowArchiveButton(){
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
                              Text("أضافة القضية الي الأرضيف",
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

 Widget _onClickEditButton(num flag){
   showDialog<void>(
     context: context,
     builder: (BuildContext context) {
       return AlertDialog(
         title: _setEditName(flag),
         content: new TextField(
           controller: inputData,),
           actions: <Widget>[
             IconButton(icon: new Icon(Icons.edit, color: third,size: 35,  ),
             alignment: Alignment.topRight,color: prime,
               onPressed:(){
                 if(flag == 1){
                  Navigator.of(context).pop();
                Firestore.instance.collection('cases').document(widget.currentCase.data['caseId']).updateData
                ({ "caseType": inputData.text,}).then((data){});
                 }
                  else if(flag == 2){
                  Navigator.of(context).pop();
                Firestore.instance.collection('cases').document(widget.currentCase.data['caseId']).updateData
                ({ "caseState": inputData.text,}).then((data){});
                 }
                   else if(flag == 3){
                  Navigator.of(context).pop();
                Firestore.instance.collection('cases').document(widget.currentCase.data['caseId']).updateData
                ({ "offenderName": inputData.text,}).then((data){});
                 }
                   else if(flag == 4){
                  Navigator.of(context).pop();
                Firestore.instance.collection('cases').document(widget.currentCase.data['caseId']).updateData
                ({ "victimName": inputData.text,}).then((data){});
                 }
                   else if(flag == 5){
                  Navigator.of(context).pop();
                Firestore.instance.collection('cases').document(widget.currentCase.data['caseId']).updateData
                ({ "crimeName": inputData.text,}).then((data){});
                 }
                   else if(flag == 6){
                  Navigator.of(context).pop();
                Firestore.instance.collection('cases').document(widget.currentCase.data['caseId']).updateData
                ({ "caseDate": inputData.text,}).then((data){});
                 }
                   else if(flag == 7){
                  Navigator.of(context).pop();
                Firestore.instance.collection('cases').document(widget.currentCase.data['caseId']).updateData
                ({ "caseNumber": inputData.text,}).then((data){});
                 }
                     Toast.show("تم تعديل القضيه بنجاح", context, duration: 3);
                                      Navigator.push(context,new MaterialPageRoute(
                          builder:(context)=>manageCases(currentCourt: widget.currentCourt,)
                      ));
                 }
             )
           ],
       );
      }
   );
 }
  
  Widget _setEditName(num flag){
     if (flag == 1){
      return Text('نوع القضيه',
      style: TextStyle(color: prime ,fontSize: 23 ,fontWeight: FontWeight.w600 ),
    );
    }
    else if (flag == 2){
      return Text('حالة القضيه',
      style: TextStyle(color: prime ,fontSize: 23 ,fontWeight: FontWeight.w600 ),);
    }
     else if (flag == 3){
      return Text(' اسم الجاني',
      style: TextStyle(color: prime ,fontSize: 23 ,fontWeight: FontWeight.w600 ),);
    }
     else if (flag == 4){
      return Text(' اسم المجني عليه',
      style: TextStyle(color: prime ,fontSize: 23 ,fontWeight: FontWeight.w600 ),);
    }
     else if (flag == 5){
      return Text(' الجريمة المرتكبه',
      style: TextStyle(color: prime ,fontSize: 23 ,fontWeight: FontWeight.w600 ),);
    }
  else if (flag == 6){
      return Text('تاريخ القضيه',
      style: TextStyle(color: prime ,fontSize: 23 ,fontWeight: FontWeight.w600 ),);
    }
  else if (flag == 7){
      return Text('رقم القضيه التسلسلي',
      style: TextStyle(color: prime ,fontSize: 23 ,fontWeight: FontWeight.w600 ),);
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
//------------------------------------END OF FUNCTIONS -------------------------------
  @override
  Widget build(BuildContext context) {
//---------------------------------------Body of Class-----------------------------------
     Size screenSize = MediaQuery.of(context).size;
     return WillPopScope(
       onWillPop: () async => false,
       child:  Scaffold(
      appBar: AppBar(
              backgroundColor: prime ,
              title: Text("تفاصيل القضيه"),
              leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop()),
            ),
            //--------------------show case details-----------------------------
     body: Container(
               padding: EdgeInsets.only( top: 20, bottom: 20.0),
                child: Column(children: <Widget>[
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                //--------------------case type----------------------
                 Expanded(
                   child: Column(
                          children: <Widget>[
                             Container(
                          padding: EdgeInsets.only(
                              left: 20, right: 20, top: 20,bottom: 5),
                          child: Text(
                            'قضية : ${widget.currentCase.data['caseType']}',
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          )),
                        //---------------edit button----------------
                       _whereIShowEditButton(1),
                       _buildSeparator(screenSize,context),
                          ],
                        ),
                   
                 ),
                //--------------------case State----------------------
                 Expanded(
                   child:  Column(
                          children: <Widget>[
                             Container(
                          padding: EdgeInsets.only(
                              left: 20, right: 20, top: 20,bottom: 5),
                          child: Center(
                              child: 
                                Text(
                          "حالة القضيه : ${widget.currentCase.data['caseState']}",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),),
                          ),
                         SizedBox(
                          width: 1.0,),
                        //---------------edit button----------------
                       _whereIShowEditButton(2),
                        _buildSeparator(screenSize,context),
                          ],
                        ),
        ),
                //--------------------offender name----------------------
                 Expanded(
                   child:Column(
                          children: <Widget>[
                             Container(
                          padding: EdgeInsets.only(
                              left: 20, right: 20, top: 20,bottom: 5),
                          child: Center(
                              child: 
                                Text(
                          " الجاني : ${widget.currentCase.data['offenderName']}",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),),
                          ),
                         SizedBox(
                          width: 1.0,),
                        //---------------edit button----------------
                       _whereIShowEditButton(3),
                        _buildSeparator(screenSize,context),
                          ],
                        ),
      )
                //--------------------victim name------------------------
                 ,Expanded(
                   child:  Column(
                          children: <Widget>[
                             Container(
                          padding: EdgeInsets.only(
                              left: 20, right: 20, top: 20, bottom: 5),
                          child: Center(
                              child: 
                                Text(
                          " المجني عليه : ${widget.currentCase.data['victimName']}",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),),
                          ),
                         SizedBox(
                          width: 1.0,),
                        //---------------edit button----------------
                       _whereIShowEditButton(4),
                        _buildSeparator(screenSize,context),
                          ],
                        ),
                    )
                //--------------------crime name----------------------
                 ,Expanded(
                   child:  Column(
                          children: <Widget>[
                             Container(
                          padding: EdgeInsets.only(
                              left: 20, right: 20, top: 20, bottom: 5),
                          child: Center(
                              child: 
                                Text(
                          "الجريمه المرتكبه : ${widget.currentCase.data['crimeName']}",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),),
                          ),
                         SizedBox(
                          width: 1.0,),
                        //---------------edit button----------------
                       _whereIShowEditButton(5),
                        _buildSeparator(screenSize,context),
                          ],
                        ),
          )
                //--------------------case date------------------------
                 ,Expanded(
                   child: Column(
                          children: <Widget>[
                             Container(
                          padding: EdgeInsets.only(
                              left: 20, right: 20, top: 20, bottom: 5),
                          child: Center(
                              child: 
                                Text(
                          " تاريخ القضيه : ${widget.currentCase.data['caseDate']}",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),),
                          ),
                         SizedBox(
                          width: 1.0,),
                        //---------------edit button----------------
                       _whereIShowEditButton(6),
                        _buildSeparator(screenSize,context),
                          ],
                        ),
                    )
                //--------------------case number----------------------
                 ,Expanded(
                   child:  Column(
                          children: <Widget>[
                             Container(
                          padding: EdgeInsets.only(
                              left: 20, right: 20, top: 20, bottom: 5),
                          child: Center(
                              child: 
                                Text(
                         " رقم القضيه التسلسلي : ${widget.currentCase.data['caseNumber']}",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),),
                          ),
                         SizedBox(
                          width: 1.0,),
                        //---------------edit button----------------
                       _whereIShowEditButton(7),
                        _buildSeparator(screenSize,context),
                          ],
                        ),
                       ),
                       
                        //--------------------Archive buttons--------------------------
                     _whereIShowArchiveButton(),
                                    ],
                    ),
                  ),
                         ])  
     )
    )
 ,
     );
     }
}
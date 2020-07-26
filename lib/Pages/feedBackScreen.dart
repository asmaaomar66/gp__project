import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import 'drawerprofile.dart';

class feedBackScreen extends StatefulWidget{

  feedBackScreen({this.currentLawyer,this.user});
    var currentLawyer;
    FirebaseUser  user;
  
  @override
  State<StatefulWidget> createState() {
    
    return new _feedBackScreenState();
  
  }

}

class _feedBackScreenState extends State<feedBackScreen>{
//-----------------------VARIABLES----------------------------
 final FirebaseAuth _auth = FirebaseAuth.instance;
       final a = Firestore.instance;

  Color prime = Color(0xff0e243b);
  Color second = Colors.white ;
  Color third =  Color(0xff0ccaee) ;
  TextEditingController inputData = new TextEditingController();
  //-----------------------begin of widgets and functions--------------------
 
  Widget _buildAddFeedbackBtn(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: InkWell(
              onTap: (){ _onClickFeedbackBtn();},
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(),
                  color: third
                ),
                child: Center(
                  child:  Text(
                    'أضف تقيمك الان! ',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ),
            ),
          ),
          SizedBox(width: 10.0,),
             ],
      ),
    );
  }
 
 Widget _onClickFeedbackBtn(){
   showDialog<void>(
     context: context,
     builder: (BuildContext context) {
       return AlertDialog(
         title: Text('تقيمك يهمنا ^^'),
         content: new TextField(
           controller: inputData,),
           actions: <Widget>[
             IconButton(icon: new Icon(Icons.add_comment, color: third,size: 35,  ),
             alignment: Alignment.topRight,color: prime,
               onPressed:(){
                 addNewFeedback();
                 Navigator.pop(context);
                 }
             )
           ],
       );
      }
   );
 }
  
void addNewFeedback() async{
final FirebaseUser user = await _auth.currentUser();
    Firestore _firestore = new Firestore();
  try{
      DocumentReference documentReference = Firestore.instance.collection('feedback').document();
      documentReference.setData({
          "feedbackId": documentReference.documentID,
          "lawyerId": widget.currentLawyer.data['id'],
          "userId":  user.uid,
          "feedbackContent": inputData.text,
    });

     Toast.show("تم أضافة تقيمك بنجاح", context,  duration: 3);
     Navigator.pop(context);
          
  /* Navigator.push(context,new MaterialPageRoute(
                          builder:(context)=>manageCases(currentCourt: widget.currentCourt,)
                      ));*/
  }
  catch(e){
    print(e);
     Toast.show("mahasalsh   ", context,  duration: 3);
  }
   
  
}

String getFeedbackOwnerName(String userId){
    String ownerName ='' ;
    StreamBuilder<QuerySnapshot>(
         stream:  a.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
             snapshot.data.documents.map((DocumentSnapshot doc) {
               if(userId == doc.data['id'])   {
              ownerName = doc.data['username'] ;
            }
             }
             ).toList();
          }
          else {
         print('error');
             }
        } ,
        );

         return ownerName ;
  }
//--------------------------------Body-----------------------------------------------
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async=> true ,
      child: Scaffold(
       backgroundColor: Colors.white,
        drawer: drawerprofile(currentUser: widget.user,),
                appBar: AppBar(title: new Text("تقيمات المستخدمين " ),),
        body:  StreamBuilder<QuerySnapshot>(
         stream:  a.collection('feedback').where("lawyerId", isEqualTo: "${widget.currentLawyer.data['id']}").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {           
            return new Container(
               padding: EdgeInsets.only(left: 5, right: 20, top: 10, bottom: 10.0),
               child: Column(children: <Widget>[
                 _buildAddFeedbackBtn(),
                 SizedBox(height: 20,),
                 Expanded(
                   child: ListView(
                     children: snapshot.data.documents.map((DocumentSnapshot doc) {
                       return InkWell(
                         child: GestureDetector(
                           child: Container(
                              margin: EdgeInsets.only(
                              top: 10, right: 10, left: 10, bottom: 10),
                          height: 80,
                          width: 500,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                              borderRadius: BorderRadius.circular(20.0),
                              boxShadow: [
                                BoxShadow(
                                    color: prime,
                                    spreadRadius: 0.0,
                                    blurRadius: 7.0,
                                    offset: Offset(6, 7))
                              ]),
                              child: Column(children: <Widget>[
                                Expanded(
                                  flex: 2,
                                child: Container(
                                    height: 80,
                                    padding: EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20.0),
                                          bottomRight: Radius.circular(20.0)),
                                      color:Colors.grey.shade400,
                                    ),
                                    child: new Column(
                                      children: <Widget>[
                                        Center(
                                          child:    Text(
                                     " التقييم: ${doc.data['feedbackContent']}",
                                    style: TextStyle(
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.w600,
                                      color: prime,
                                    ),
                                  ),
                                        ),
                                      
                                 // getFeedbackOwnerName(doc.data['userId']),
                                   Text(
                                     'من : ${getFeedbackOwnerName(doc.data['userId'])}',
                                    style: TextStyle(
                                      fontSize: 21.0,
                                      fontWeight: FontWeight.w600,
                                      color: prime,
                                    ),
                                  ),
                               
                                      ],
                                    ),
                                   )),
                                
                              ],),
                           ),
                      onTap: (){}
                         ),
                       );
                     }).toList()
                   ,),
                 ),
               ],),
            );
            
          }
          else {
         return SizedBox();
             }
        } ,
        ),
           
    ) ,);
  }

}
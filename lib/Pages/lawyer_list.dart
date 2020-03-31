import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'drawerprofile.dart';
import 'lawyerScreen.dart';
class LawyerList extends StatefulWidget {
final FirebaseUser value ;
  LawyerList({Key key ,this.value}) : super(key: key);
 @override
  _LawyerList createState()=> new _LawyerList();
  }



  class _LawyerList extends State<LawyerList>{
      final a = Firestore.instance;
    
  @override
  Widget build(BuildContext context) {
    return
      StreamBuilder<QuerySnapshot>(
       stream:  a.collection('users').where("role", isEqualTo: "2").snapshots(),
       builder: (context, snapshot) {
           if (snapshot.hasData) {
                return Scaffold(
                drawer: drawerprofile(currentUser: widget.value,),
                appBar: AppBar(title: new Text("من فضلك اختر محامٍ" ),),  
                body: new ListView(children: <Widget>[
                
          Padding(
            padding: const EdgeInsets.only(left:10.0,right: 15.0,top: 10.0),
            child: Container(
              child: new Text('نبذه عن القانون',
                style: TextStyle(fontSize: 23.5 , color: Colors.teal,fontStyle: FontStyle.italic,
                    fontWeight:FontWeight.w600 ),
                textDirection: TextDirection.rtl,
              ),
            ),
          ),
                  Container(
            padding: EdgeInsets.only(left:20.0,right: 20.0,bottom: 5.0),
            child:  Text('- هو مجموعة القواعد القانونية التي تنظم علاقة الأفراد فيما بينهم من حيث صلة النسب والزواج  '
                'وما ينشأ عنه من مصاهرة وولادة وولاية وحضانة وحقوق وواجبات متبادلة وما قد يعتريها من'
                '  انحلال تترتب عليه حقوق في النفقة والحضانة والإرث والوصية.',
              style: TextStyle(fontSize: 17 ,
                  color: Colors.teal,
                  fontWeight:FontWeight.w300 ),
              textDirection: TextDirection.rtl,
            ),
          ),
          Column(
                   children: snapshot.data.documents.map((doc) {
                        return
                         
                          new Card(
                            color: Colors.white,
                            margin: EdgeInsets.only(
                            left: 3, right: 3.0, top: 3.0, bottom: 10.0),
                            child: ListTile(title: Text(doc.data['fname']+" "+doc.data['lname'],
                            style: TextStyle(fontSize: 20,color: Colors.teal[900]),
                            textAlign: TextAlign.right,),
                            subtitle: Row(children: <Widget>[ 
                              Container(child: Icon(
                                                FontAwesomeIcons.solidStar,
                                                color: Colors.amber,
                                                size: 15.0,),),
                             Container(child: Icon(
                                                FontAwesomeIcons.solidStar,
                                                color: Colors.amber,
                                                size: 15.0,),),
                             Container(child: Icon(
                                                FontAwesomeIcons.solidStar,
                                                color: Colors.amber,
                                                size: 15.0,),),]),
                  onTap: (){
                               Navigator.of(context).push((MaterialPageRoute(
                                 builder: (context)=>lawyerScreen(currentLawyer: doc, user: widget.value, id: doc.data['id'] ))));}
                            /*onTap: (){ Navigator.of(context).push((MaterialPageRoute(builder: (context)=> questionPage(id: doc.data['id'], user: widget.value ))));}*/,));
                                  }).toList(),)]));}
                    else {
                        return SizedBox();
                         }
                      });

  }}
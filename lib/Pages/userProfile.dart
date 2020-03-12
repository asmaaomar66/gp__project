import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class FbCprofileState extends StatefulWidget{
  final FirebaseUser currentuser;
  final DocumentSnapshot user;
  FbCprofileState({this.user, this.currentuser});
  //_FbCprofileState createstate() => _FbCprofileState();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FbCprofileState();
  }


}

class _FbCprofileState extends State<FbCprofileState>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: null,
      body: new ListView(
          children: <Widget>[
            new Column(
              children: <Widget>[
                Container(
                  child: Stack(
                      alignment: Alignment.bottomCenter,
                      overflow: Overflow.visible,
                      children: <Widget>[
                        Container(
                            child: Row(children: <Widget>[
                              Expanded(child:
                              Container(
                                  height: 200.0,
                                  width: 220.0,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage("https://cdn.ida2at.com/media/2018/04/%D8%A3%D8%AD%D9%85%D8%AF-%D8%AE%D8%A7%D9%84%D8%AF-%D8%AA%D9%88%D9%81%D9%8A%D9%82-6.jpg")
                                    ),
                                  )))
                            ]
                            )

                        ),
                        Positioned(top: 100,
                          child: Container(
                            height: 190.0,
                            width: 190.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(image: NetworkImage(
                                    "https://upload.wikimedia.org/wikipedia/ar/thumb/a/a9/%D8%A3%D8%AD%D9%85%D8%AF_%D8%AE%D8%A7%D9%84%D8%AF_%D8%AA%D9%88%D9%81%D9%8A%D9%82.jpg/220px-%D8%A3%D8%AD%D9%85%D8%AF_%D8%AE%D8%A7%D9%84%D8%AF_%D8%AA%D9%88%D9%81%D9%8A%D9%82.jpg")),
                                border: Border.all(
                                  color: Colors.teal[900],
                                  width: 6.0,
                                )
                            ),

                          )
                          ,),

                      ]),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  height: 130.0,


                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      Text('أحمد خالد توفيق', style: TextStyle(
                          fontStyle: FontStyle.italic, fontSize: 28.0),),
                      SizedBox(width: 5.0,),
                      Icon(Icons.check_circle, color: Colors.blueAccent,),
                    ],),

                ),
                SizedBox(height: 8.0,),

                Container(child: Text(
                  'جعل الشباب يقرأون', style: TextStyle(fontSize: 18.0,),),

                ),
                Icon(Icons.edit, size: 15.0, color: Colors.blueAccent,)],


            ),
            new Card(
              color: Colors.teal[900],
              margin: EdgeInsets.only(
                  left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
              child: new Row(mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  Icon(Icons.person_pin, textDirection: TextDirection.ltr,
                    color: Colors.white,
                    size: 23,),
                  Padding(padding: EdgeInsets.only(top:10 , bottom: 10,),
                    child: Text(
                      'أسم المستخدم', textDirection: TextDirection.rtl,
                      style: TextStyle(fontSize: 25, color: Colors.white),),


                  ),


                ],),
            ),
            new Card(color: Colors.teal[900],
              margin: EdgeInsets.only(
                  left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
              child: new Row(mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  Icon(Icons.email, textDirection: TextDirection.rtl,
                    color: Colors.white,
                    size: 23,),
                  Padding(padding: EdgeInsets.only(top: 10, bottom: 10,),
                    child: Text('البريد الألكترونى', textDirection: TextDirection.rtl,
                      style: TextStyle(fontSize: 25, color: Colors.white),),


                  ),


                ],),
            ),
            new Card(color: Colors.teal[900],
              margin: EdgeInsets.only(
                  left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
              child: new Row(mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  Icon(Icons.lock, textDirection: TextDirection.rtl,
                    color: Colors.white,
                    size: 23,),
                  Padding(padding: EdgeInsets.only(top: 10, bottom: 10,),
                    child: Text('كلمه السر', textDirection: TextDirection.rtl,
                      style: TextStyle(fontSize: 25, color: Colors.white),),


                  ),


                ],),
            ),
            new Card(color: Colors.teal[900],
              margin: EdgeInsets.only(
                  left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
              child: new Row(mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  Icon(Icons.mobile_screen_share, textDirection: TextDirection.rtl,
                    color: Colors.white,
                    size: 23,),
                  Padding(padding: EdgeInsets.only(top: 10, bottom: 10,),
                    child: Text('رقم الهاتف', textDirection: TextDirection.rtl,
                      style: TextStyle(fontSize: 25, color: Colors.white),),


                  ),


                ],),
            ),


            new Card(//color: Colors.teal[900],
              //margin: EdgeInsets.only(
              //left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
              child: new Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[            new RaisedButton.icon(onPressed:() =>print('hhhhhhhh'), icon: new Icon(Icons.edit,color: Colors.white,), label:new Text('تعديل',style:TextStyle(color: Colors.white)

                    ,),color: Colors.teal[900],
                  )]),

            ) ]),


    );
  }
}
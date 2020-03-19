import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';



class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _HomeState();
  }




}

class _HomeState extends State<Home> {
  String name='';
  void onClick(){
    setState(() {
      name='ASMAHAN';
    });
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(

        appBar: new AppBar(

          backgroundColor: Colors.teal[900],

          actions: <Widget>[
            Icon(Icons.arrow_forward),
          ],

          title: new Text('الأفوكادو',
            textDirection: TextDirection.rtl,


          )


          ,

        ),
        body: new ListView(
            children: <Widget>[

              new Card(

                  color: Colors.white,
                  margin: EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
                  child: new Column(crossAxisAlignment: CrossAxisAlignment.stretch,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(top: 10, bottom: 10,),
                        child: Text('ما هى إجراءات الطلاق؟',
                          //textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 25, color: Colors.teal[900]),),


                      ),
                      new Card(
    color: Colors.white,
    margin: EdgeInsets.only(
   left: 3, right: 3.0, top: 3.0, bottom: 10.0),
    child: new Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
    Padding(padding: EdgeInsets.only(top: 2, bottom: 7,),
    child:
   new Text('أن يحلف أنك طالق بالثلاثة',
    //textDirection: TextDirection.rtl,
       textAlign: TextAlign.right,
    style: TextStyle(fontSize: 15, color: Colors.teal[900])),


    ),

  ] )),
      new Row(
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          IconButton(icon: new Icon(FontAwesomeIcons.heart), onPressed: onClick,alignment: Alignment.topRight,color: Colors.teal[900],),
          IconButton(icon: new Icon(FontAwesomeIcons.share), onPressed: onClick,alignment: Alignment.topRight,color: Colors.teal[900],),
        ],
      ),

      new Column(
        
        children: <Widget>[
           TextField( keyboardType: TextInputType.text,
            minLines:1,
            maxLines: 3,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,

            decoration: new InputDecoration(//icon: new Icon(Icons.help,color: Colors.teal[900]),
              //focusColor: Colors.amber,
              border: OutlineInputBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(7),bottom:Radius.circular(7) ))
              ,
              hintText: 'أستكمال الأسئلةً',
              icon: new Icon(Icons.arrow_back_ios,color: Colors.grey[600],),
              fillColor: Colors.teal[900],
              contentPadding:EdgeInsets.all(10)

            ),

          )  ],
        
      )
                      
    ],
                    


      ),

    )
                      ]));



  }}

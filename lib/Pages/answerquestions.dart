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

        title: new Text('الإجابه',
          textDirection: TextDirection.rtl,


        )


        ,

      ),
      body: new Container(
          padding: new EdgeInsets.all(10),
          margin: new EdgeInsets.all(10),
          child: new Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //padding:padding()

              new Text('هل صليت على النبى اليوم؟',style: TextStyle(fontSize: 30,color: Colors.teal[900]),textAlign: TextAlign.right,),
              //new RaisedButton.icon(onPressed: onClick, icon: new Icon(Icons.question_answer), label:new Text('أسأل')
              //),


              new TextField(

                //autocorrect: true,
                //autofocus: true,


 maxLines:10 ,
                keyboardType: TextInputType.text,

                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,

                decoration: new InputDecoration(//icon: new Icon(Icons.help,color: Colors.teal[900]),
                  focusColor: Colors.amber,
                  border: OutlineInputBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(10),bottom:Radius.circular(10) ))
                  ,
                  hintText: 'الإجابهً',
                  fillColor: Colors.teal[900],

                ),
              ),

       new Row(
         children: <Widget>[
           IconButton(icon:Icon( Icons.add_photo_alternate),iconSize:50, onPressed: onClick,color: Colors.grey[500],),

           RaisedButton.icon(onPressed: onClick, icon:new Icon(Icons.arrow_forward_ios,color: Colors.white,) , label:new Text('أجب',style:TextStyle(color: Colors.white)

         ,),color: Colors.teal[900],),

           IconButton(icon:Icon(FontAwesomeIcons.twitter),iconSize:30, onPressed: onClick,color: Colors.teal[900],),
           IconButton(icon:Icon(FontAwesomeIcons.facebook),iconSize:30, onPressed: onClick,color: Colors.teal[900],),
           //IconButton(icon:Icon( FontAwesomeIcons.instagram),iconSize:20, onPressed: onClick,color: Colors.teal[900],),

         ],


    ),

  ]
    )

        ));


  }
}


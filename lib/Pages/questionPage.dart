import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';




class questionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new questionPageState();
  }




}

class questionPageState extends State<questionPage> {
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
          Icon(Icons.list),
        ],
        title: new Text(' الأسئله',
          textDirection: TextDirection.ltr,


        )


        ,

      ),
      body: new Container(
          padding: new EdgeInsets.all(20),
          margin: new EdgeInsets.all(20),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              //new Text('أسأل'),
              //new RaisedButton.icon(onPressed: onClick, icon: new Icon(Icons.question_answer), label:new Text('أسأل')
              //),



              new TextField(
                //autocorrect: true,
                //autofocus: true,

                keyboardType: TextInputType.text,

                textDirection: TextDirection.rtl,
                //textAlign: TextAlign.center,

                decoration: new InputDecoration(icon: new Icon(Icons.help,color: Colors.teal[900]),
                  focusColor: Colors.amber,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                  hintText: 'أسال سؤالاً',
                  fillColor: Colors.teal[900],

                ),
              ),
              new RaisedButton.icon(onPressed: onClick, icon: new Icon(Icons.question_answer,color: Colors.white,), label:new Text('أسأل',style:TextStyle(color: Colors.white)

                ,),color: Colors.teal[900],
              ),
            ],
          )

      ),
    );

  }
}


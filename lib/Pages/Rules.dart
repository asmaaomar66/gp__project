import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'AddRoles.dart';
//import 'AddRules.dart';

class Rules extends StatefulWidget {
  @override
 State<StatefulWidget> createState() {
    return new _Rules();
  }
}

class _Rules extends State<Rules> {
  @override
  Widget build(BuildContext context) {
    
    return new Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlueAccent, 
        onPressed: (){
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) => AddRoles(),);
        },
        child: Icon(Icons.add ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: new AppBar(
        backgroundColor: Colors.grey[700],
        title: new Text("الأفوكاتو", style: new TextStyle(fontSize: 21,fontWeight: FontWeight.bold),),
      ),);
  }
  
  
  }


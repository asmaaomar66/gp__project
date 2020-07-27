import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gpproject/Pages/AdminHome.dart';
import 'package:gpproject/Pages/manage_rules.dart';

import 'AddRoles.dart';

class Rules extends StatefulWidget {
  @override
 State<StatefulWidget> createState() {
    return new _Rules();
  }
}

class _Rules extends State<Rules> {
   Color prime = Color(0xff0e243b);
  Color second = Colors.white ;
  Color third =  Color(0xff0ccaee) ;
  @override
  Widget build(BuildContext context) {
    
    return new WillPopScope(
    onWillPop: () async => false,
    child: new Scaffold(
       appBar: new AppBar(
        title: new Text("الأفوكاتو", style: new TextStyle(fontSize: 21,fontWeight: FontWeight.bold),),
        actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.home,
                color: second,

              ),
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => AdminHome()));
              },
            )
          ],
                       ),
      body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 80.0,bottom: 45.0),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new CircleAvatar(
                    backgroundColor: third , 
                    maxRadius: 87.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.add_circle,
                            color: second,

                          ),
                          onPressed: () {
                            Navigator.push(context,new MaterialPageRoute(
                                builder:(context)=>AddRoles()
                            ));
                          },
                        ),
                        new SizedBox(
                          height: 3.0,
                        ),
                        new Text("إضافة_القوانين", style: TextStyle(fontWeight: FontWeight.bold,color: second),),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new CircleAvatar(
                    backgroundColor:  third,
                    maxRadius: 87.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.markunread_mailbox,
                            color: second,
                          ),
                          onPressed: () {
                             Navigator.push(context,new MaterialPageRoute(builder:(context)=>managerules()));
                          },
                        ),
                        new SizedBox(
                          height: 3.0,
                        ),
                        new Text("إدارة_القوانين",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
     
    ),
    );
  }
  
  
  }


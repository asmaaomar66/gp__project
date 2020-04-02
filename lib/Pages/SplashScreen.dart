import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'HelloApp.dart';
import 'Home.dart';

class splash_screen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new splash_screenState();
  }
}


class splash_screenState extends State<splash_screen> {

 @override
 void initState(){
      super.initState();
      Future.delayed(Duration(seconds: 3 ) , () {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => HelloApp()));
      } );
 }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Size screenSize = MediaQuery.of(context).size;
    return new Scaffold(
        body: new Container(
        decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage("image/3.jpg"), fit: BoxFit.cover)
        )
        ),
    ) ;

  }
}
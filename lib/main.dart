import 'package:flutter/material.dart';
import 'package:gpproject/Pages/HelloApp.dart' ;



void main() => runApp(new MaterialApp(home: new MyApp(),));

class MyApp extends StatelessWidget {
  Color prime = Colors.red[800] ;
  Color second = Colors.white ;
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      builder: (BuildContext context, Widget child) {
        return new Directionality(
          textDirection: TextDirection.rtl,
          child: new Builder(
            builder: (BuildContext context) {
              return new MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaleFactor: 1.0,
                ),
                child: child,
              );
            },
          ),
        );
      },
     theme: ThemeData(
       primaryColor: prime,
     ),


      home: new HelloApp()

      ,

    );
  }

}



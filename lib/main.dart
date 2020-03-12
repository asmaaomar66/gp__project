import 'package:flutter/material.dart';
import 'package:gpproject/Pages/HelloApp.dart' ;



void main() => runApp(new MaterialApp(home: new MyApp(),));

class MyApp extends StatelessWidget {
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



      home: new HelloApp()

      ,

    );
  }

}



import 'package:flutter/material.dart';
import 'signupCourt.dart';
import 'signupLawyer.dart';
import 'signupUser.dart';

class Buttons extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _Buttons();
  }
}

class _Buttons extends State<Buttons> {
   Color prime = Color(0xff0e243b);
  Color second = Colors.white ;
  Color third =  Color(0xff0ccaee) ;
  @override
  Widget build(BuildContext context) {

    return new WillPopScope(
    onWillPop: () async => false,
    child: new Scaffold(
        backgroundColor: prime,
        //Color.fromRGBO(1, 44, 45, 15),

        body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(70.0),
            ),

            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text(

                  " إنشاء حساب كـ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                    color: third,
                    //  color: Color.fromRGBO(218, 154, 28, 15),
                  ),

                ),

              ],

            ),

            Padding(
              padding: const EdgeInsets.only(left: 15,right: 15,bottom: 15,top: 60),
              child: new RaisedButton(
                onPressed: ()  {
                  Navigator.push(context,new MaterialPageRoute(
                      builder:(context)=>SignUpLawyer()
                  ));
                },
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                  side: BorderSide(color: third, width: 3),
                ),
                child: new Text(
                  "محامي",
                  style: TextStyle(color: Colors.black, fontSize: 25,fontWeight: FontWeight.bold),
                ),
              ),
            ),


            Padding(
              padding: const EdgeInsets.all(15.0),
              child: new RaisedButton(
                onPressed: () {
                  Navigator.push(context,new MaterialPageRoute(
                      builder:(context)=>SignUpUser()
                  ));
                },
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                  side: BorderSide(color: third, width: 3),
                ),
                child: new Text(
                  "مستخدم",
                  style: TextStyle(color: Colors.black, fontSize: 25,fontWeight: FontWeight.bold),
                ),
              ),
            ),


            Padding(
              padding: const EdgeInsets.all(15.0),
              child: new RaisedButton(
                onPressed: () {
                  Navigator.push(context,new MaterialPageRoute(
                      builder:(context)=>SignUpCourt()
                  ));
                },
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                  side: BorderSide(color:third, width: 3),
                ),
                child: new Text(
                  "محكمة",
                  style: TextStyle(color: Colors.black, fontSize: 25,fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        )


      ),  );
  }
}

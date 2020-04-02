import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gpproject/Auth/choosesignup.dart';
import 'package:gpproject/Auth/Login.dart';
class HelloApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HelloApp();
  }
}

class _HelloApp extends State<HelloApp> {
  Color prime = Color(0xff0e243b);
  Color second = Colors.white ;
  Color third =  Color(0xff0ccaee) ;
  @override
  Widget build(BuildContext context) {
    return new Scaffold( 
      backgroundColor: prime,
      // Color.fromRGBO(1, 44, 45, 15),
      body:
      ListView(
        children: <Widget>[
          
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(left: 80,right: 80,bottom: 40,top: 80),
                child: new Image.asset(
                  'image/12.png',
                  height: 170.0,
                  width: 170.0,
                ),)
            ],
          ),


          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(padding: EdgeInsets.all(33),
                child: new Text(
                  " وَإِذَا حَكَمْتُم بَيْنَ النَّاسِ أَن تَحْكُمُواْ بِالْعَدْلِ ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 21,
                    color: second,
                  ),
                ),),




              MaterialButton(
                onPressed: (){
                  Navigator.push(context,new MaterialPageRoute(
                      builder:(context)=>Buttons()
                  ));
                },

                shape: RoundedRectangleBorder(
                  side: BorderSide(color: second),
                ),
                color: second,
                child: Text("إنشاء حساب", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),),
                textColor: third,

              ),





              new Row(
                children: <Widget>[
                  SizedBox(width: 80,height: 120,
                  ),
                  new Text("هل لديك حساب بالفعل؟", style: TextStyle(color: second,fontSize: 18)),

                  new FlatButton(
                    child: Text(
                      'تسجيل دخول',
                      style: TextStyle(color: second),
                    ),
                    onPressed: () {
                      Navigator.push(context,new MaterialPageRoute(
                          builder:(context)=>Login()
                      ));
                    },
                  ),


                ],
              ),

            ],
          )

        ],
      ),
    );



  }
}

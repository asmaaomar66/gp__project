import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'AddTime.dart';
class FreeTime extends StatefulWidget {
  @override
 State<StatefulWidget> createState() {
    return new _FreeTime();
  }
}

class _FreeTime extends State<FreeTime> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal[900], 
        onPressed: (){
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                    child: AddTime(),
                   );
              });
        },
        child: Icon(Icons.add ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: new AppBar(
        backgroundColor: Colors.teal[900],
        title: new Text("الأفوكاتو", style: new TextStyle(fontSize: 21,fontWeight: FontWeight.bold),),
      ),
      
      body:
      
      
      new Column(children: <Widget>[
       new Card(
        
         color: Colors.cyan[100],
         margin: EdgeInsets.all(10),
         child: Column(
           children: <Widget>[
          Row(
          children: <Widget>[
           SizedBox(width: 10,),
           new Icon(Icons.date_range,),
           new Text("الأحد",textDirection: TextDirection.rtl,textAlign: TextAlign.right,
           style: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.w700),),
           SizedBox(width: 200,),
            new Icon(Icons.timer),
            new Text("3 مرات",textDirection: TextDirection.rtl,textAlign: TextAlign.right,
           style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w700),),
           Row(children: <Widget>[

           ],),

         ],
       ),
       Row(
         mainAxisAlignment: MainAxisAlignment.spaceAround,
         children: <Widget>[
         new Text("11:12",textDirection: TextDirection.rtl,textAlign: TextAlign.right,
           style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w500),),
           SizedBox(width: 80,) , 
            new Text("3:04",textDirection: TextDirection.rtl,textAlign: TextAlign.right,
           style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w500),), 
           SizedBox(width: 80,) ,  
           new Text("09:10",textDirection: TextDirection.rtl,textAlign: TextAlign.right,
           style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w500),),  
              ],),  ],
       
       ),
      ),
      new Card(
        
         color: Colors.red[100],
         margin: EdgeInsets.all(10),
         child: Column(
           children: <Widget>[
          Row(
          children: <Widget>[
           SizedBox(width: 10,),
           new Icon(Icons.date_range,),
           new Text("الإثنين",textDirection: TextDirection.rtl,textAlign: TextAlign.right,
           style: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.w700),),
           SizedBox(width: 185,),
            new Icon(Icons.timer),
            new Text("مرتين",textDirection: TextDirection.rtl,textAlign: TextAlign.right,
           style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w700),),
           Row(children: <Widget>[

           ],),

         ],
       ),
       Row(
         mainAxisAlignment: MainAxisAlignment.spaceAround,
         children: <Widget>[
         new Text("11:12",textDirection: TextDirection.rtl,textAlign: TextAlign.right,
           style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w500),),
           SizedBox(width: 200,) , 
            new Text("03:04",textDirection: TextDirection.rtl,textAlign: TextAlign.right,
           style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w500),),  
           
              ],),  ],
       
       ),
      ),
      new Card(
        
         color: Colors.cyan[100],
         margin: EdgeInsets.all(10),
         child: Column(
           children: <Widget>[
          Row(
          children: <Widget>[
           SizedBox(width: 10,),
           new Icon(Icons.date_range,),
           new Text("الجمعة",textDirection: TextDirection.rtl,textAlign: TextAlign.right,
           style: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.w700),),
           SizedBox(width: 180,),
            new Icon(Icons.timer),
            new Text("3 مرات",textDirection: TextDirection.rtl,textAlign: TextAlign.right,
           style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w700),),
           Row(children: <Widget>[

           ],),

         ],
       ),
       Row(
         mainAxisAlignment: MainAxisAlignment.spaceAround,
         children: <Widget>[
         new Text("11:12",textDirection: TextDirection.rtl,textAlign: TextAlign.right,
           style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w500),),
           SizedBox(width: 75,) , 
            new Text("03:04",textDirection: TextDirection.rtl,textAlign: TextAlign.right,
           style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w500),), 
           SizedBox(width: 80,) ,  
           new Text("09:10",textDirection: TextDirection.rtl,textAlign: TextAlign.right,
           style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w500),),  
              ],),  ],
       
       ),
      ),
      
],),
      );

  }
}
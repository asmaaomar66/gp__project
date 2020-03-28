import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gpproject/Pages/FreeTime.dart';
import 'package:gpproject/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';


//import 'package:gp_project/models/user.dart';

class AddTime extends StatefulWidget {
  final FirebaseUser currentUser;
  final User user;
AddTime({Key key, this.currentUser, this.user}) : super(key: key);
  @override
 State<StatefulWidget> createState() {
    return new _AddTime();
  }
}

class _AddTime extends State<AddTime> { 
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;

    List<String> _times = ['مرة', 'مرتين', 'تلاتة', 'أربعة','خمسة']; // Option 2
    String _selectedtime; // Option 2
     List<String> _days = ['السبت','الأحد', 'الإثنين', 'الثلاثاء', 'الاربعاء','الخميس','الجمعة']; // Option 2
    String _selectedday; // Option 2
    List<String> _clocks = ['12:01','01:02',
    '02:03','03:04','04:05','06:07','07:08', '08:09', '09:10', '10:11','11:12',]; // Option 2
    String _selectedclock; // Option 2
    List<String> _nights = ['صباحًا','مساءًا.']; // Option 2
    String _selectednight; // Option 2
     String  timeNum = "timeNum";
     String  day = "day";
     String  time = "time";
     String  amORpm = "amORpm";







void addtime () async{
   final FirebaseUser user = await _auth.currentUser();
    Firestore _firestore = new Firestore();
    
  try{
    

      DocumentReference documentReference = Firestore.instance.collection('Time').document();
      documentReference.setData({
         "lawyerId" :  user.uid,
         'timeNum' : _selectedtime,
          'day' : _selectedday,
          'time': _selectedclock,
          'amORpm' : _selectednight,
          'timeId' : documentReference.documentID,

           

    });
    Navigator.push(context,new MaterialPageRoute(
                          builder:(context)=>FreeTime()
                      ));

  }
  catch(e){
    print(e);
  }
   
  
}
  
  
   @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.green[50],
      body: 

      new ListView( 
      
      
    children: <Widget>[
      
      
      new Column(
      children: <Widget>[
      Padding(padding: EdgeInsets.only(left:100,top:20,bottom: 20.0,right: 100,),
      
       child: new Text("الجدول", style:TextStyle(fontWeight: FontWeight.w900,color: Colors.teal[900],fontSize: 28),),
      ),
      
     

    
    
   
       Padding(padding: EdgeInsets.only(left: 80),
         child:
       Text("متاح كام مرة باليوم؟",textAlign: TextAlign.start ,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20,)),
       ),
       
     
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             
             children: <Widget>[
            Text("في اليوم",textDirection: TextDirection.rtl,
            style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20)), 
            DropdownButton(
              
            hint: Text('اختر عدد المرات',textDirection: TextDirection.rtl,style: TextStyle(color: Colors.black,fontSize: 18)), // Not necessary for Option 1
            value: _selectedtime,
            onChanged: (newValue) {
              setState(() {
                _selectedtime = newValue;
              });
            },
            items: _times.map((time) {
              return DropdownMenuItem(
                child: new Text(time),
                value: time,
              );
            }).toList(),
          ),
         


        

           ],
           ),
           SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(left: 80),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               
               children: <Widget>[

              DropdownButton(
              hint: Text('اختر اليوم',textDirection: TextDirection.rtl,style: TextStyle(color: Colors.black,fontSize: 18)), // Not necessary for Option 1
              value: _selectedday,
              onChanged: (newValue) {
                setState(() {
                  _selectedday = newValue;
                });
              },
              items: _days.map((day) {
                return DropdownMenuItem(
                  child: new Text(day),
                  value: day,
                );
              }).toList(),
            ),
       
                   Text("اليوم",textAlign: TextAlign.start ,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20,)),

             ],
             ),
          ),

 new Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[

           DropdownButton(
            hint: Text('اختر الميعاد',textDirection: TextDirection.rtl,style: TextStyle(color: Colors.black,fontSize: 18)), // Not necessary for Option 1
            value: _selectedclock,
            onChanged: (newValue) {
              setState(() {
                _selectedclock = newValue;
              });
            },
            items: _clocks.map((clock) {
              return DropdownMenuItem(
                child: new Text(clock),
                value: clock,
              );
            }).toList(),
          ),

          DropdownButton(
            hint: Text('مساءًا أم صباحًا',textDirection: TextDirection.rtl,style: TextStyle(color: Colors.black,fontSize: 18)), // Not necessary for Option 1
            value: _selectednight,
            onChanged: (newValue) {
              setState(() {
                _selectednight = newValue;
              });
            },
            items: _nights.map((night) {
              return DropdownMenuItem(
                child: new Text(night),
                value: night,
              );
            }).toList(),
          ),


        ],
      ),







        Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: new RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onPressed: (){
              Navigator.of(context).pop();
               addtime();


            },
            color: Colors.teal[900],
            child: Text('تم', style: TextStyle(color: Colors.white,fontSize: 21)),
          ),
        ),
        
    ],
    ),
   ],
      ),
      
       
      );
     
     //Future <String> addtime ({Map newTime});
     //String timeId =  this.CRUD.addtime(newTime: newTime);
    

     


  }
}
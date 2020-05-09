
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gpproject/Pages/FreeTime.dart';
import 'package:gpproject/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
//import'package:saraah/data.dart';

import 'package:flutter/cupertino.dart';


class AddTime extends StatefulWidget {
  final FirebaseUser currentUser;
  final User user;
AddTime({Key key, this.currentUser, this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    var u=new FallTime();
List _allTimes=u.fillTimes();
    return new AddTimeState(_allTimes);
  }
  
}
class AddTimeState extends State<AddTime> {
  Color prime = Color(0xff0e243b);
  Color second = Colors.white ;
  Color third =  Color(0xff0ccaee) ;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;

  List _visability=[false,false,false,false,false,false,false];
  List _times=[];
AddTimeState(this._times);
 List  _selectedTime=[];

  void addTime(){
_selectedTime.clear();
     void check( int index , bool state, String time){
   if(state==true){
    
     _selectedTime.add({'timeId':_times[index]['timeId'],'date':_times[index]['date'],
     'day':_times[index]['day'],
     'time':time,'state':state,
     'lawyerId':_times[index]['lawyerId']});

   }
  }
  for(int i=0;i<7;i++){
    Map<String,bool> dayTimes=_times[i]['dayTimes'];
    dayTimes.forEach((k ,v)=> check(i, v,k));
  }
 //Navigator.push(context, MaterialPageRoute(builder:(context)=>Data(_selectedTime)));
  
 }
 void _addFire() async{
   addTime();
   final FirebaseUser user = await _auth.currentUser();
    Firestore _firestore = new Firestore();

    for(int i=0;i<_selectedTime.length;i++){
      try{
    

      DocumentReference documentReference = Firestore.instance.collection('Time').document();
      documentReference.setData({
         "lawyerId" :  user.uid,
         "date":_selectedTime[i]['date'],
          'day' : _selectedTime[i]['day'],
          'time': _selectedTime[i]['time'],
          
          'timeId' : documentReference.documentID,
          "state":true

           

    });}
 catch(e){
    print(e);
  }

  
    }
     Navigator.push(context,new MaterialPageRoute(
                          builder:(context)=>FreeTime( user:user.uid)
                      ));
    
 }
  Widget build(BuildContext context) {
    
    return new Scaffold(
      appBar: AppBar(
        title: new Text("افوكادو"),
        backgroundColor: prime,
        actions: <Widget>[
          FlatButton(onPressed: (){
          _addFire();
            
          },child:Text('تم',style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),))
        ],
      ),
      body:Container(
            //margin: EdgeInsets.only(top:40),
            //color: Color(0xff27aaaa),
            child: Stack(children: <Widget>[
              Container(
               height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("image/law.jpg"),
                fit: BoxFit.cover,
              )),
                /*child:  Text("اختار مواعيدك المتاحة للحجز",
                 style: TextStyle(
                                fontSize: 23.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),),*/
               
                // width: 300.0,
                

                  //color:Color(0xff76adad)
               
              ),
              Container(
                  padding:
                      EdgeInsets.only(right: 10, left: 10, top: 20),
                      child:Column(
                        
          children: <Widget>[
            Column(
              children: <Widget>[
                 Center(
            
               child:Text("اختار مواعيدك المتاحة للحجز",
                 style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.white))
             
           ),
            Center(
            
               child:Text('اضغط علي اليوم المناسب لاختيار المواعيد',
                 style: TextStyle(
                                fontSize: 20.0,
                                //fontWeight: FontWeight.w500,
                                color: Colors.white))
             
           ),

              ],
            ),
             
         
           Expanded(
            
             child: ListView.builder(
             itemCount: _times.length,
             itemBuilder: (context,index){
               Map<String,bool> dayTimes=_times[index]['dayTimes'];
         var x=new DateFormat("yyy-MM-dd").format(_times[index]['date']);
        return Container(
          margin: EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 2),
          padding:EdgeInsets.only(left: 5, right: 20, top: 10, bottom: 2),
          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
          child:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
           GestureDetector(
             child:Container(
               child:Row(
                 children: <Widget>[
                   Text(" ${_times[index]['day']} "+" $x ",
             style: TextStyle(
                                fontSize: 23.0,
                                fontWeight: FontWeight.w500,
                                color: prime,)
            ) ,
            SizedBox(
              width: MediaQuery.of(context).size.width/10 ,
            ),
             Text("اضغط هنا",
             style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                                color: third)
            ) ,
                 ],
               )
            ),
             onTap: (){
               setState(() {
                 _visability[index]=!_visability[index];
               });
             }
           ),
            Visibility(
             visible: _visability[index],
             child: Column(
               children:dayTimes.keys.map((String key){
                 return Row(
                   children: <Widget>[
                      new Icon(Icons.timer,color:Color(0xff314d4d)),
                     Expanded(child: CheckboxListTile(
                   title: Text("$key",
                  style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.black)),
                   value: dayTimes[key], 
                   activeColor: Colors.red,
                   checkColor: Colors.white,
                   onChanged: (bool state){
                     setState(() {
                      dayTimes[key]=state;
                     });
                   }))
                   ],
                 );

               }).toList(),
             ) ,

            ),
            
            
            
          ],
          
          )
        );
             },

           ),)
          ],
           /*
         */) ,)
              ]))
       );
   
  }

}
 
class FallTime{
  final _dates=List<DateTime>.generate(8, (i)=>
DateTime.utc(
DateTime.now().year,
DateTime.now().month,
DateTime.now().day
).add(Duration(days: i)));


 List<String> _days = [ 'الإثنين', 'الثلاثاء', 
                       'الاربعاء','الخميس',
                      'الجمعة','السبت','الأحد']; // Option 2
// Option 2

List _times=[];



List fillTimes(){
 List< Map<String,bool>>t=[{
                   '08:09   صباحا':false,
                  '09:10   صباحا':false, 
                  '10:11   صباحا':false,
                  '11:12   صباحا':false,
                   '12:01   ظهرا':false,
                  '01:02   ظهرا ':false,
                  '02:03   مساءا':false,  
                  '03:04   مساءا':false, 
                  '04:05   مساءا':false,
                  '06:07   مساءا':false,
                  '07:08   مساءا':false,
                  },
                  {
                    '08:09  صباحا':false,
                  '09:10  صباحا':false, 
                  '10:11  صباحا':false,
                  '11:12  صباحا':false,
                  '12:01  ظهرا':false,
                  '01:02  ظهرا ':false,
                  '02:03  مساءا':false,  
                  '03:04  مساءا':false, 
                  '04:05  مساءا':false,
                  '06:07  مساءا':false,
                  '07:08  مساءا':false,
                  }
                  ,{
                    '08:09 صباحا':false,
                  '09:10 صباحا':false, 
                  '10:11 صباحا':false,
                  '11:12 صباحا':false,
                  '12:01 ظهرا':false,
                  '01:02 ظهرا ':false,
                  '02:03 مساءا':false,  
                  '03:04 مساءا':false, 
                  '04:05 مساءا':false,
                  '06:07 مساءا':false,
                  '07:08 مساءا':false,
                  },
                  {
                    ' 08:09   صباحا':false,
                  ' 09:10   صباحا':false, 
                  ' 10:11   صباحا':false,
                  ' 11:12   صباحا':false,
                  ' 12:01   ظهرا':false,
                  ' 01:02   ظهرا ':false,
                  ' 02:03   مساءا':false,  
                  ' 03:04   مساءا':false, 
                  ' 04:05   مساءا':false,
                  ' 06:07   مساءا':false,
                  ' 07:08   مساءا':false,
                  }
                  ,{
                      '08:09   صباحا ':false,
                  '09:10   صباحا' :false, 
                  '10:11   صباحا ':false,
                  '11:12   صباحا ':false,
                  '12:01   ظهرا ':false,
                  '01:02   ظهرا  ':false,
                  '02:03   مساءا ':false,  
                  '03:04   مساءا ':false, 
                  '04:05   مساءا ':false,
                  '06:07   مساءا ':false,
                  '07:08   مساءا ':false,
                },
                  {
                     ' 08:09   صباحا ':false,
                  ' 09:10   صباحا ':false, 
                  ' 10:11   صباحا ':false,
                  ' 11:12   صباحا ':false,
                  ' 12:01   ظهرا ':false,
                  ' 01:02   ظهرا ':false,
                  ' 02:03   مساءا ':false,  
                  ' 03:04   مساءا' :false, 
                  ' 04:05   مساءا ':false,
                  ' 06:07   مساءا ':false,
                  ' 07:08   مساءا ':false,
                 }
                  ,{
                    ' 08:09  صباحا':false,
                  ' 09:10 صباحا':false, 
                  ' 10:11   صباحا ':false,
                  ' 11:12   صباحا ':false,
                  ' 12:01  ظهرا':false,
                  ' 01:02  ظهرا':false,
                  ' 02:03  مساءا':false,  
                  ' 03:04  مساءا':false, 
                  ' 04:05  مساءا':false,
                  ' 06:07  مساءا':false,
                  ' 07:08  مساءا':false,
                  }
                  ]; 
 
   for(var i=0;i<7;i++){
      var day=_days[(_dates[i+1].weekday)-1];
     _times.add({'date':_dates[i+1],'dayTimes':t[i],'day':day,});
   }
    return _times;
 }






}



  
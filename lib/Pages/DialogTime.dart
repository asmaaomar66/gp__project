import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gpproject/Pages/FreeTime.dart';
import 'package:gpproject/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'drawerprofile.dart';


class FreeTime extends StatefulWidget {
  final FirebaseUser currentUser;
  //final String user;
  final String lawyerId;
   String timeId;
  String selectTime = "اختار ميعاد الحجز";
FreeTime({Key key, this.currentUser,this.lawyerId}) : super(key: key);
  @override
 State<StatefulWidget> createState() {
    return new _FreeTime();
  }
}

class _FreeTime extends State<FreeTime> {
 

  List <List<Map<String,String>>> freeTime=  [[],[],[],[],[],[],[]];
  List groupingTimes=[];
  List allTimes=[];
    final _dates=List<DateTime>.generate(8, (i)=>
DateTime(
DateTime.now().year,
DateTime.now().month,
DateTime.now().day
).add(Duration(days: i)));

List<String> _days = [ 'الإثنين', 'الثلاثاء', 
                       'الاربعاء','الخميس',
                      'الجمعة','السبت','الأحد']; 
                  

void _groupingTime(List times){
  groupingTimes.clear();
  for(int c=0;c<7;c++){
    if( freeTime[c].length!=0){
       freeTime[c].clear();
    }
    }
  
  for(int i=0;i<times.length;i++){
    var x=DateTime.parse(times[i]['date'].toDate().toString());
   
    var c=times[i]['day'];
    for(int j=1;j<_dates.length;j++){
       var now =DateTime.parse(_dates[j].toString());
      
     var day=_days[(_dates[j].weekday)-1];
     
      if(x.isAtSameMomentAs(now)){
       
           freeTime[j-1].add({'time':times[i]['time'],'id':times[i]['timeId']});
        
      }
      else {
       
      }

    }
  }
  for(int c=0;c<7;c++){
    if( freeTime[c].length!=0){
     
         groupingTimes.add({'date':_dates[c+1],'Times':freeTime[c]});
     
     
    }
    //print(groupingTimes.length);
  }
}


  @override
  Widget build(BuildContext context) {

  
    return  StreamBuilder<QuerySnapshot>  (
     
     stream: Firestore.instance.collection('Time').where("lawyerId" , isEqualTo:  widget.lawyerId)
      .where("state", isEqualTo:true).snapshots(),
      builder: (context, snapshot) {
         if (snapshot.hasData) {
          

          allTimes=snapshot.data.documents;
         
     _groupingTime(allTimes);
     
      if(groupingTimes.isNotEmpty){
        return  SimpleDialog(
             contentPadding:
                EdgeInsets.only(top: 5, bottom: 20, right: 5, left: 5),
            backgroundColor: Colors.white,
            titlePadding: EdgeInsets.only(
              top: 5,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
             title: 
            
                Column(
                  
              children: <Widget>[
                Center(
                  child:Text(
                 "المواعيد المتاحة خلال الاسبوع",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                      color: Color(0xffcb4154)),
                ),
                ),
                SizedBox(
                  height: 20,
                ),

                
                Column(
                 
                  children:groupingTimes.map((group){
                     var x=new DateFormat("yyy-MM-dd").format(group['date']);
                     var day=_days[(group['date'].weekday)-1];
                     List times=group['Times'];
                    return Container(
                      padding: EdgeInsets.only(
                            left: 3, right: 3.0, top: 3.0, bottom: 10.0),
                      child: Card(
                      margin: EdgeInsets.only(
                            left: 3, right: 3.0, top: 3.0, bottom: 10.0),
                            
                      child:Column(
                         mainAxisAlignment: MainAxisAlignment.end,
                   crossAxisAlignment: CrossAxisAlignment.end,

                        children: <Widget>[
                        
                        Text("  $x"+"  $day  ",style: TextStyle(color:Color(0xff0ccaee),fontSize: 18,fontWeight: FontWeight.w700),),
                        SizedBox(
                  height: 10,
                )
                ,Column(
                         mainAxisAlignment: MainAxisAlignment.end,
                   crossAxisAlignment: CrossAxisAlignment.end,
                          children:times.map((time){
                          return GestureDetector(
                            
                            child:Row(
                         mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,

                              children: <Widget>[

                                
                                 Text("  ${time['time']}  ",style: TextStyle(color: Colors.black,fontSize: 15)),
                                 new Icon(Icons.timer,color:Color(0xff314d4d)),

                              ],
                            ),
                           
                        onTap: () {
                           var t = " يوم $day  الساعة ${time['time']} ";
                         setState(() {
                           widget.timeId=time['id'];
                          widget.selectTime= t; 
                          
                         });
                         Navigator.pop(context);
                         
                        },);

                        }).toList(),)

                     
                      ],)


                    ),
                    );

                  }).toList(),
                )
                
                ]
                )
                
                
                );

      }else{
        return SimpleDialog(
             contentPadding:
                EdgeInsets.only(top: 5, bottom: 20, right: 5, left: 5),
            backgroundColor: Colors.white,
            titlePadding: EdgeInsets.only(
              top: 5,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
             title: 
            Container(
               margin: EdgeInsets.only(
                            left: 10, right: 3.0, top: 3.0, bottom: 10.0),
              child:Center(
                 child: Text(
                 "لا توجد مواعيد متاحة خلال هذا الاسبوع ",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                     color:Color(0xff0ccaee)),
                ),
               )
            )
                   
                   );
      }

           
                

         }
         else{
           return  SimpleDialog(
             contentPadding:
                EdgeInsets.only(top: 5, bottom: 20, right: 5, left: 5),
            backgroundColor: Colors.white,
            titlePadding: EdgeInsets.only(
              top: 5,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
             title: 
             Center(
                child: 
                Text(
                 "من فضلك انتظر قليلا ....",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                      color: Color(0xffcb4154)),
                ),
                
                
                )
                
                );
                
            
         }
      });}}
      
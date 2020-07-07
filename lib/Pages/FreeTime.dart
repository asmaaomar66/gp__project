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
  final String user;
  
FreeTime({Key key, this.currentUser, this.user}) : super(key: key);
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
  
    return  StreamBuilder<QuerySnapshot>(
      stream:  Firestore.instance.collection('Time').where("lawyerId" , isEqualTo: widget.user )
      .where("state", isEqualTo:true).orderBy('date').startAfter([DateTime.now()]).snapshots(),
      builder: (context, snapshot) {
         if (snapshot.hasData) {
 
   allTimes=snapshot.data.documents;   
     _groupingTime(allTimes);

      if(groupingTimes.isNotEmpty){
        return   new Scaffold(
      appBar: AppBar(
        title: new Text("افوكادو"),
         actions: <Widget>[
          FlatButton(onPressed: (){
            //Navigator.push(context, MaterialPageRoute(builder:(context)=>Test()));
          },child:Text('تم',style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),))
        ],
        backgroundColor: Color(0xff0e243b),),
        //drawer: drawerprofile(currentUser: widget.currentUser,),
        body: Container(
          child: ListView(
             children:groupingTimes.map((group){
                     var x=new DateFormat("yyy-MM-dd").format(group['date']);
                     var day=_days[(group['date'].weekday)-1];
                     List times=group['Times'];
                     return new Card(
        
         color: Color(0xff0ccaee),
        margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 2),
        child:Column(
                         mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                        Text("  $x"+"  $day  ",style: TextStyle(color:Colors.white,fontSize: 18,fontWeight: FontWeight.w700),),
                        SizedBox(
                  height: 10,
                ),
                Column(
                         mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.start,
                          children:times.map((time){
                          return Row(
                         mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,

                              children: <Widget>[   
                                new Icon(Icons.timer,color:Color(0xff314d4d)),                             
                                 Text("  ${time['time']}  ",style: TextStyle(color: Colors.black,fontSize: 15)),
                                 

                              ],
                           
                           
                        );

                        }).toList(),)
                
                
                ]));
                       
                     
                     }).toList(),

          )
          
          ));
      }

            return new Scaffold(
      appBar: AppBar(
        title: new Text("افوكادو"),
         actions: <Widget>[
          FlatButton(onPressed: (){
            //Navigator.push(context, MaterialPageRoute(builder:(context)=>Test()));
          },child:Text('تم',style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),))
        ],
        backgroundColor: Color(0xff314d4d),),
        //drawer: drawerprofile(currentUser: widget.currentUser,),
        body: Container(
          child: ListView(
            children:snapshot.data.documents.map((doc) {
              //var t=DateTime.fromMillisecondsSinceEpoch(doc.data['date'],isUtc: true);
              var c=DateTime.parse(doc.data['date'].toDate().toString());
               var x=new DateFormat("yyy-MM-dd").format(c);
              return new Card(
        
         color: Colors.cyan[100],
        margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 2),
         
         child: Column(
           children: <Widget>[
             Row(children: <Widget>[
               SizedBox(width: 10,) ,
             new Icon(Icons.timer,color:Color(0xff314d4d)),
             new Text(" ${doc.data['time']} ",
             style: TextStyle(color: Colors.red,fontSize: 15,fontWeight: FontWeight.w700))
           ],),
          Row(
          children: <Widget>[
           //new Icon(Icons.date_range,color:Color(0xff314d4d),),
           new Text("  ${doc.data['day']}"+" $x " ,
           style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w700),),
    
         ],
       ),
       
       ]
             ));
            }).toList(),
          ),
        ),
        );
         }
         else{
           return SizedBox();
         }
      }
    );

  }
}
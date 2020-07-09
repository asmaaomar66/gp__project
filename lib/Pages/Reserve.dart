import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gpproject/Pages/userViewTime.dart';
import 'package:gradient_text/gradient_text.dart';
import 'drawerprofile.dart';
import 'package:gpproject/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
//import'package:saraah/data.dart';

import 'package:flutter/cupertino.dart';


class Reservation extends StatefulWidget {
   String lawyerId;
   FirebaseUser user;
   
  Reservation({Key key ,this.lawyerId, this.user}) : super(key: key);
  @override
  _ReservationState createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;
final _formKey=GlobalKey<FormState>();
  FocusNode myFocusNode = new FocusNode();
 final GlobalKey<ScaffoldState> scaffold=new GlobalKey<ScaffoldState>();
  
  TextEditingController _userName=new TextEditingController();
  TextEditingController _case =new TextEditingController ();
  DateTime _date;
  String _timeId;
  String _selectTime = "اختار ميعاد الحجز";
String _reserveTime="موعد الحجز";
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

 //--------------------------------------------------------------------------------------------------------------------------------------------
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


//-------------------------------------------------------------------------------------------------------------
  Future _dialogTime() async {
    switch (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return
           StreamBuilder<QuerySnapshot>  (
     
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
                  height: 10,
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
                          _timeId=time['id'];
                          _selectTime= t; 
                          _date=group['date'];
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

      }
      else{
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
      });
        })){

        }}
  
//---------------------------------------------------------------------------------------------------------------------------------------------------
  
  void _addReserve() async{
  
   final FirebaseUser user = await _auth.currentUser();
    Firestore _firestore = new Firestore();

    
      try{
    

      DocumentReference documentReference = Firestore.instance.collection('Reserve').document();
      documentReference.setData({

         "userId" :  user.uid,
         "lawyerId":widget.lawyerId,
          'userName' : _userName.text,
          'Case': _case.text,
          'reserveId' : documentReference.documentID,
          'timeId':_timeId,
          'date':_date,
          'pepar':"لم يتم الرد حتي الان",
    
    });
    Firestore.instance.collection('Time').document(_timeId).updateData({ "state" : false });
  DocumentReference documentRef = Firestore.instance.collection('notifiReserve').document();
      documentRef.setData({
         "lawyerId":widget.lawyerId,
          "state":false
    });
    }
 catch(e){
    print(e);
  }

  
    
     /*Navigator.push(context,new MaterialPageRoute(
                          builder:(context)=>FreeTime( user:user.uid)
                      ));*/
    
 }
 //---------------------------------------------------------------------------------------------------------
 
 //-------------------------------------------------------------------------------------
 @override
  Widget build(BuildContext context) {
   
    return Scaffold(
         drawer: drawerprofile(currentUser: widget.user,),
                appBar: AppBar(title: new Text("حجز" ),), 
        body: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("image/law.jpg"),
                fit: BoxFit.cover,
              )),
            ),
            Center(
              child: Container(
                width: 500.0,
                height: 530.0,
                margin:
                    EdgeInsets.only(top: 80.0, right: 10, left: 15, bottom: 15),
                padding: EdgeInsets.only(
                    top: 20.0, left: 20.0, right: 20.0, bottom: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [Colors.white70, Colors.white70],
                    begin: Alignment.centerRight,
                    end: Alignment(-1.0, -1.0),
                  ),
                ),
                child: ListView(
                  children: <Widget>[
                    Center(
                      child: GradientText(
                        "حجز ميعاد",
                        gradient: LinearGradient(colors: [
                          Color(0xffb57281),
                          Color(0xff656255),
                          Color(0xff779ecb),
                          Color(0xff5a6457)
                        ]),
                        style: TextStyle(
                            fontSize: 40.0,
                            //  wordSpacing: 10,
                            // fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Amiri"),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Form(
                      key:_formKey ,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:<Widget>[
                          Text(
                      '    اسم المدعي',
                      style: TextStyle(
                          color: Color(0xff620530),
                          // fontWeight: FontWeight.bold,
                          // fontStyle: FontStyle.italic,
                          textBaseline: TextBaseline.alphabetic),
                    ),
                    TextFormField(
                     validator: (value) {
                      if (value.isEmpty) {
                        return 'من فضلك ادخل  الاسم';
                      }
                      
                      return null;
                    },
                      obscureText: false,
                    controller:_userName ,
                     decoration: InputDecoration(
                      alignLabelWithHint: true,
                      hintText: "اسم صاحب المشكلة",
                      contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 20.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                    ),
                     // onSaved: (input) => _userName = input,
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Text(
                      '     تفاصيل المشكلة',
                      style: TextStyle(
                          color: Color(0xff620530),

                          // fontWeight: FontWeight.bold,
                          //fontStyle: FontStyle.italic,
                          textBaseline: TextBaseline.alphabetic),
                    ),
                   TextFormField(
                      validator: (value){
                        if(value.isEmpty){
                          return " من فضلك ادخل المشكلة";
                        }
                        else return null;
                      },
                      maxLines: 2,
                      obscureText: false,
                  controller:_case ,
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      hintText: "ادخل المشكلة",
                      fillColor: Color(0xff0e243b),
                      contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 20.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                          
                    ),
                     //onSaved: (input) => _case = input,

                      
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    
                  ],
                ),
                     ) 
                     ,Text(
                      ' $_reserveTime',
                      style: TextStyle(
                          color: Color(0xff620530),
                          // fontWeight: FontWeight.bold,
                          //fontStyle: FontStyle.italic,
                          textBaseline: TextBaseline.alphabetic),
                    ),
                    Container(
                        width: 100.0,
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(25.0),
                          color: Colors.white,
                        ),
                        child: SizedBox(
                          height: 25.0,
                          child: FlatButton(
                              onPressed: () {
                               _dialogTime();

                              },
                              color: Colors.white,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(_selectTime),
                                  ),
                                  Icon(Icons.arrow_forward_ios)
                                ],
                              )),
                        )),
                    SizedBox(
                      height: 50.0,
                    ),
                    Container(
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            side: BorderSide(color: Color(0xff0e243b))),
                        onPressed: () {
                          if(_formKey.currentState.validate()){
                            if(_selectTime=="اختار ميعاد الحجز"){
                              setState(() {
                                _reserveTime="من فضلك اختار ميعاد الحجز";
                              });
                            }
                            else{
                              _addReserve();
                              Navigator.of(context).push((MaterialPageRoute(builder: (context)=> UserTimesPage( currentUser: widget.user ))));
                            //  Scaffold.of(context).showSnackBar(SnackBar(content:Text("تم حجز الميعاد")));


                            }
                          }
                          
                        },
                        color:Color(0xff0e243b),
                        textColor: Colors.white,
                        child: Text("احجز الان",
                            style: TextStyle(
                              fontSize: 15.0,
                            )),
                      ),
                    ),],

                      )),

                   ),
                    
          ]));
            
       
  }
}
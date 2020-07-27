import 'dart:ffi';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gpproject/models/reserve.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:flip_card/flip_card.dart';

import 'drawerprofile.dart';

class UserTimesPage extends StatefulWidget {
  UserTimesPage({Key key, this.currentUser}) : super(key: key);
  final FirebaseUser currentUser;
  @override
  _UserTimesState createState() => _UserTimesState();
}
class _UserTimesState extends State<UserTimesPage> {
  
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<String> _days = [
    'الإثنين',
    'الثلاثاء',
    'الاربعاء',
    'الخميس',
    'الجمعة',
    'السبت',
    'الأحد'
  ];

  List<List<Map<String, String>>> freeTime = [[], [], [], [], [], [], []];
  List groupingTimes = [];
  List allTimes = [];
  final _dates = List<DateTime>.generate(
      8,
      (i) => DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .add(Duration(days: i)));

  //--------------------------------------------------------------------------------------------------------------------------------------------
  void _groupingTime(List times) {
    groupingTimes.clear();
    for (int c = 0; c < 7; c++) {
      if (freeTime[c].length != 0) {
        freeTime[c].clear();
      }
    }

    for (int i = 0; i < times.length; i++) {
      var x = DateTime.parse(times[i]['date'].toDate().toString());

      var c = times[i]['day'];
      for (int j = 1; j < _dates.length; j++) {
        var now = DateTime.parse(_dates[j].toString());

        var day = _days[(_dates[j].weekday) - 1];

        if (x.isAtSameMomentAs(now)) {
          freeTime[j - 1]
              .add({'time': times[i]['time'], 'id': times[i]['timeId']});
        } else {}
      }
    }
    for (int c = 0; c < 7; c++) {
      if (freeTime[c].length != 0) {
        groupingTimes.add({'date': _dates[c + 1], 'Times': freeTime[c]});
      }
      //print(groupingTimes.length);
    }
  }

//------------------------------------------------------------------------------------------------
  Stream<List> getData() async* {
    var reservesStream = Firestore.instance
        .collection("Reserve")
        .where("userId", isEqualTo: widget.currentUser.uid)
        .where('date', isGreaterThanOrEqualTo: DateTime.now())
        .orderBy('date').snapshots();
    List reservations = [];
    reservations.clear();
    await for (var reserveSnapshot in reservesStream) {
      for (var reserveDoc in reserveSnapshot.documents) {
        var reservation;
        var lawyerSnapshot = await Firestore.instance
            .collection('users').document(reserveDoc['lawyerId'])  .get();
       print(reserveDoc['timeId']);
        var lawyerName =   lawyerSnapshot['fname'] + " " + lawyerSnapshot['lname'];
         var timeSnapshot = await Firestore.instance
            .collection('Time')
            .document(reserveDoc['timeId']) .get();
        reservation = {
          "id": reserveDoc['reserveId'],"timeId": reserveDoc['timeId'],
          "lawyerName": lawyerName,
          "date": reserveDoc['date'], "time": timeSnapshot[('time')],
          'cases': reserveDoc['cases'],
          'caseDetails': reserveDoc['caseDetails'],
          'pepar': reserveDoc['pepar'], 'lawyerId': reserveDoc['lawyerId'],
          'userName':reserveDoc['userName']
        };

        reservations.add(reservation);
      }
      yield reservations;
    }
  }

  //-----------------------------------------------------------------------------------------------
 
 Future _dialogTime(String lawyerId, String timeId, Map delayData) async {
    switch (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection('Time')
                  .where("lawyerId", isEqualTo: lawyerId)
                  .where("state", isEqualTo: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  allTimes = snapshot.data.documents;

                  _groupingTime(allTimes);

                  if (groupingTimes.isNotEmpty) {
                    return SimpleDialog(
                        contentPadding: EdgeInsets.only(
                            top: 5, bottom: 20, right: 5, left: 5),
                        backgroundColor: Colors.white,
                        titlePadding: EdgeInsets.only(
                          top: 5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        title: Container(
              height: MediaQuery.of(context).size.height/2,
              width: 300, child : SingleChildScrollView(
                           
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                          Center(
                            child: Text(
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
                            children: groupingTimes.map((group) {
                              var x = new DateFormat("yyy-MM-dd")
                                  .format(group['date']);
                              var day = _days[(group['date'].weekday) - 1];
                              List times = group['Times'];
                              return Container(
                                padding: EdgeInsets.only(
                                    left: 3,
                                    right: 3.0,
                                    top: 3.0,
                                    bottom: 10.0),
                                child: Card(
                                    margin: EdgeInsets.only(
                                        left: 3,
                                        right: 3.0,
                                        top: 3.0,
                                        bottom: 10.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          "  $x" + "  $day  ",
                                          style: TextStyle(
                                              color: Color(0xff0ccaee),
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: times.map((time) {
                                            return GestureDetector(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: <Widget>[
                                                  Text("  ${time['time']}  ",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 15)),
                                                  new Icon(Icons.timer,
                                                      color: Color(0xff314d4d)),
                                                ],
                                              ),
                                             onTap: () {
                                                Firestore.instance
                                                    .collection('Time')
                                                    .document(timeId)
                                                    .updateData(
                                                        {"state": true});
                                                Firestore.instance
                                                    .collection('Reserve')
                                                    .document(delayData['reserveId'])
                                                    .updateData(
                                                        {"timeId": time['id']});
                                                Firestore.instance
                                                    .collection('Time')
                                                    .document(time['id'])
                                                    .updateData(
                                                        {"state": false});
                                                setState(() {
                                                  getData();
                                                });
                                                _addDelayNotifi(delayData);

                                                Navigator.pop(context);
                                              },
                                            );
                                          }).toList(),
                                        )
                                      ],
                                    )),
                              );
                            }).toList(),
                          )
                        ])))
                        );
                  } else {
                    return SimpleDialog(
                        contentPadding: EdgeInsets.only(
                            top: 5, bottom: 20, right: 5, left: 5),
                        backgroundColor: Colors.white,
                        titlePadding: EdgeInsets.only(
                          top: 5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        title: Container(
                            margin: EdgeInsets.only(
                                left: 10, right: 3.0, top: 3.0, bottom: 10.0),
                            child: Center(
                              child: Text(
                                "لا توجد مواعيد متاحة خلال هذا الاسبوع ",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff0ccaee)),
                              ),
                            )));
                  }
                } else {
                  return SimpleDialog(
                      contentPadding: EdgeInsets.only(
                          top: 5, bottom: 20, right: 5, left: 5),
                      backgroundColor: Colors.white,
                      titlePadding: EdgeInsets.only(
                        top: 5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      title: Center(
                        child: Text(
                          "من فضلك انتظر قليلا ....",
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                              color: Color(0xffcb4154)),
                        ),
                      ));
                }
              });
        })) {
    }
  }
//------------------------------------------------------------------------------------------------------------------
  void _addCancelNotifi(Map canselData)async {
    final FirebaseUser user = await _auth.currentUser();
    Firestore _firestore = new Firestore();  
      try{
          DocumentReference documentRef = Firestore.instance.collection('notifiCansel').document();
      documentRef.setData({
      'userName':canselData['userName'],
      'case':canselData['case'],
      'caseDetails':canselData['caseDetails'],
      'time':canselData['time'],
      'notifiId':documentRef.documentID,
      
           
    });
  DocumentReference document = Firestore.instance.collection('lawyerNotifi').document();
      document.setData({
      'lawyerId':canselData['lawyerId'],
      'notifiId':documentRef.documentID,
      'type':0,
      'open':false,
      'view':false,
      'date':DateTime.now(),
      'id':document.documentID
    });
      }
      catch(e){
    print(e);
  }
  }
//--------------------------------------------------------------------------
  void _addDelayNotifi(Map delayData) async{
   final FirebaseUser user = await _auth.currentUser();
    Firestore _firestore = new Firestore();  
      try{
          DocumentReference documentRef = Firestore.instance.collection('notifiDelay').document();
      documentRef.setData({
      'oldTime':delayData['time'],
      'reserveId':delayData['reserveId'],
      'notifiId':documentRef.documentID,
      'userName':delayData['userName'],
      'case':delayData['case']
           
    });
  DocumentReference document = Firestore.instance.collection('lawyerNotifi').document();
      document.setData({
      'lawyerId':delayData['lawyerId'],
      'notifiId':documentRef.documentID,
      'type':2,
      'open':false,
      'view':false,
      'date':DateTime.now(),
      'id':document.documentID
    });
      }
      catch(e){
    print(e);
  }
  }
//--------------------------------------------------------------------------
  Future _cancelDialog(String id, String timeId, Map canselData) async {
    switch (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
              contentPadding:
                  EdgeInsets.only(top: 0.0, bottom: 5, right: 10, left: 5),
              backgroundColor: Colors.white,
              titlePadding: EdgeInsets.only(
                top: 5,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              title: Container(
                  height: 70.0,
                  //color: Color(0xff314d4d),
                  child: Center(
                    child: Text(
                      "الغاء الميعاد",
                      style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w600,
                          color: Color(0xffcb4154)),
                    ),
                  )),
              children: <Widget>[
                Container(
                  child: Text(
                    "  هل تريد الغاء ميعاد الحجز لهذه القضية",
                    style: TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.w600, height: 2),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.only(left: 10, right: 25, top: 20, bottom: 10),
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            side: BorderSide(color: Color(0xffcb4154))),
                        onPressed: () {
                          // _addNotification(id,time);
                          Firestore.instance
                              .collection('Time')
                              .document(timeId)
                              .updateData({"state": true});
                          Firestore.instance
                              .collection('Reserve')
                              .document(id)
                              .delete();
                          Firestore.instance
                              .collection('notifiReserve')
                              .document(timeId)
                              .updateData({"deleted": true});
                          _addCancelNotifi(canselData);
                          setState(() {
                            getData();
                         
                          });
                          Navigator.of(context).pop();
                        },
                        textColor: Colors.white,
                        child: Text("تاكيد",
                            style: TextStyle(
                              fontSize: 15.0,
                            )),
                      ),
                      SizedBox(
                        width: 40.0,
                      ),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            side: BorderSide(color: Color(0xff16bbbb))),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        color: Colors.white,
                        textColor: Colors.black,
                        child: Text("خروج",
                            style: TextStyle(
                              fontSize: 15.0,
                            )),
                      ),
                    ],
                  ),
                )
              ]);
        })) {
    }
  }

  ///////////////////////////////////////////////////////////////--------------------------------
  ///

  ///
  @override
  Widget build(BuildContext context) {
   Widget streamBuilder = StreamBuilder<List>(
        stream: getData(),
        builder:
            (BuildContext context, AsyncSnapshot<List> reservationsSnapshot) {
          if (reservationsSnapshot.hasError) {
            return Text("${reservationsSnapshot.error}");
          }
          if (reservationsSnapshot.hasData) {
            return Scaffold(
                drawer: drawerprofile(
                  currentUser: widget.currentUser,
                ),
                appBar: AppBar(
                  title: new Text("مواعيد الحجوزات"),
                ),
                body: Container(
                  // padding:EdgeInsets.only(top:40),
                  color: Color(0xff0e243b),
                  child: Stack(children: <Widget>[
                    Column(children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height / 3,
                        // width: 300.0,
                        margin: EdgeInsets.only(right: 70.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(900.0)),
                          gradient: LinearGradient(
                            colors: [Color(0xff27aaaa), Color(0xff16bbbb)],
                            begin: Alignment.centerRight,
                            end: Alignment(-1.0, -1.0),
                          ),

                          //color:Color(0xff76adad)
                        ),
                      ),
                    ]),
                    Container(
                      padding: EdgeInsets.only(
                          right: 20, left: 20, bottom: 10, top: 70),
                      child: ListView(
                        children: reservationsSnapshot.data.map((doc) {
                          var x =
                              DateTime.parse(doc['date'].toDate().toString());
                          var date = new DateFormat("MM-dd").format(x);
                          var day = _days[(x.weekday) - 1];
                          var time = day + " الساعة " + doc['time'];
                          Map canselData = {
                            'userName': doc['userName'],
                            'case': doc['cases'],
                            'time': time,
                            'caseDetails': doc['caseDetails'],
                            'lawyerId':doc['lawyerId']
                          };
                          Map delayData={
                            'time': time,
                           'reserveId': doc['id'],
                            'lawyerId':doc['lawyerId'],
                            'userName':doc['userName'],
                            'case':doc['cases'],
                          };
                          return Container(
                              margin: EdgeInsets.only(bottom: 20.0),
                              child: Column(children: <Widget>[
                                Container(
                                    //color: Colors.white12,

                                    child: FlipCard(
                                        direction: FlipDirection.VERTICAL,
                                        front: Container(

                                            //height: 250,
                                            width: 500,
                                            // margin:EdgeInsets.only(bottom:10.0) ,
                                            child: Stack(
                                              //  alignment: Alignment.topLeft,
                                              children: <Widget>[
                                                Container(
                                                 // height: 160,
                                                  width: 500,
                                                  margin: EdgeInsets.only(
                                                      top: 40.0),
                                                  padding: EdgeInsets.only(
                                                      top: 15.0, right: 5),
                                                  decoration: BoxDecoration(
                                                      color: Color(0xff0e243b),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topRight: Radius
                                                                  .circular(
                                                                      20.0),
                                                              topLeft: Radius
                                                                  .circular(
                                                                      20.0)),
                                                      border: Border.all(
                                                          color: Color(
                                                              0xff69a5a5))),
                                                  child: Column(
                                                    children: <Widget>[
                                                      Text(
                                                        " الاستاذ:" +
                                                            "${doc['lawyerName']}",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      Divider(
                                                        color: Colors.grey,
                                                      ),
                                                      Container(
                                                          child: Text(
                                                        "نوع القضية :${doc['cases']}",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color:
                                                                Colors.white),
                                                      )),
                                                      Container(
                                                          child: Text(
                                                        "تفاصيل القضية :${doc['caseDetails']}",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color:
                                                                Colors.white),
                                                      )),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                    width: 130.0,
                                                    height: 60.0,
                                                    child: Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: 5,
                                                                top: 5),
                                                        margin: EdgeInsets.only(
                                                            right: 5.0),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(25),
                                                          gradient:
                                                              LinearGradient(
                                                            colors: [
                                                              Color(0xff1bd0d0),
                                                              Color(0xff1bd0d0)
                                                            ],
                                                            begin: Alignment
                                                                .centerRight,
                                                            end: Alignment(
                                                                -1.0, -1.0),
                                                          ),
                                                        ),
                                                        child: Column(
                                                            children: <Widget>[
                                                              // Icon(Icons.calendar_today,color: Color(0xffe6a651),),
                                                              Text(
                                                                  "${doc['time']}",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .red,
                                                                      fontSize:
                                                                          15.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600)),
                                                              Text("$day" + " " + " $date",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          15.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600))
                                                            ])))
                                              ],
                                            )),
                                        back: Container(
                                          padding: EdgeInsets.all(5),
                                          // margin:EdgeInsets.only(bottom:10.0) ,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                  topRight:
                                                      Radius.circular(20.0),
                                                  topLeft:
                                                      Radius.circular(20.0)),
                                              border: Border.all(
                                                  color: Color(0xff69a5a5))),
                                          height: 200,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Center(
                                                  child: Text(
                                                      "الاوراق المطلوبة",
                                                      style: TextStyle(
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            Color(0xffcb4154),
                                                      ))),
                                              Divider(color: Colors.black),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text("${doc['pepar']}")
                                            ],
                                          ),
                                        ))),
                                Container(
                                  // height:30.0,
                                  decoration: BoxDecoration(
                                      color: Color(0xff0e243b),
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(20.0),
                                          bottomLeft: Radius.circular(20.0)),
                                      border:
                                          Border.all(color: Color(0xff69a5a5))),
                                  padding: EdgeInsets.only(left: 7),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      RaisedButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            side: BorderSide(
                                                color: Color(0xffcb4154))),
                                        onPressed: () {
                                          _cancelDialog(doc['id'],
                                              doc['timeId'], canselData);
                                        },
                                        color: Color(0xffcb4154),
                                        textColor: Colors.white,
                                        child: Text("الغاء",
                                            style: TextStyle(
                                              fontSize: 15.0,
                                            )),
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      RaisedButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            side: BorderSide(
                                                color: Color(0xff16bbbb))),
                                        onPressed: () {
                                          _dialogTime(doc['lawyerId'],
                                              doc['timeId'],delayData);
                                        },
                                        color: Color(0xff16bbbb),
                                        textColor: Colors.white,
                                        child: Text("تاجيل",
                                            style: TextStyle(
                                              fontSize: 15.0,
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ]));
                        }).toList(),
                      ),
                    )
                  ]),
                ));
          } else {
            return Scaffold(
                drawer: drawerprofile(
                  currentUser: widget.currentUser,
                ),
                appBar: AppBar(
                  title: new Text("مواعيد الحجوزات"),
                ),
                body: Container(
                    // padding:EdgeInsets.only(top:40),
                    color: Color(0xff0e243b),
                    child: Stack(children: <Widget>[
                      Column(children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height / 3,
                          // width: 300.0,
                          margin: EdgeInsets.only(right: 70.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(900.0)),
                            gradient: LinearGradient(
                              colors: [Color(0xff27aaaa), Color(0xff16bbbb)],
                              begin: Alignment.centerRight,
                              end: Alignment(-1.0, -1.0),
                            ),
                          ),
                        )
                      ]),
                     Center(
                       child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            border: Border.all(color: Color(0xff69a5a5))),
                        margin: EdgeInsets.only(
                            left: 10, right: 10, bottom: 10, top: 10),
                        child: Center(
                          child: Text(
                            "  لا توجد مواعيد حتي الان .....    ",
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ),
                      )
                     )
                    ])));
          }
        });

    

    return streamBuilder;
  }
}

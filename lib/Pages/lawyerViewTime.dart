import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

import 'drawerprofile.dart';

class LawyerTimesPage extends StatefulWidget {
  FirebaseUser user;

  LawyerTimesPage({Key key, this.user}) : super(key: key);
  @override
  _LawyerTimesState createState() => _LawyerTimesState();
}

class _LawyerTimesState extends State<LawyerTimesPage> {
  FocusNode myFocusNode = new FocusNode();
  TextEditingController _replay = new TextEditingController();
  bool _visibilityReplay=false;
  String replay=" تعديل الرد ";
  List<String> _days = [
    'الإثنين',
    'الثلاثاء',
    'الاربعاء',
    'الخميس',
    'الجمعة',
    'السبت',
    'الأحد'
  ];
  Stream<List> getData() async* {
    var reservesStream = Firestore.instance
        .collection("Reserve")
        .where("lawyerId", isEqualTo: widget.user.uid)
        .where('date', isGreaterThanOrEqualTo: DateTime.now())
        .orderBy('date')
        .snapshots();
    List reservations = [];
    reservations.clear();
    await for (var reserveSnapshot in reservesStream) {
      for (var reserveDoc in reserveSnapshot.documents) {
        var reservation;
        var userSnapshot = await Firestore.instance
            .collection('users')
            .document(reserveDoc['userId'])
            .get();
        var timeSnapshot = await Firestore.instance
            .collection('Time')
            .document(reserveDoc['timeId'])
            .get();
        var lawyerSnapshot = await Firestore.instance
            .collection('users')
            .document(reserveDoc['lawyerId'])
            .get();
        var userName = userSnapshot['fname'] + " " + userSnapshot['lname'];
        var lawyerName =
            lawyerSnapshot['fname'] + " " + lawyerSnapshot['lname'];
        reservation = {
          "id": reserveDoc['reserveId'],
          "userName": userName,
          "date": timeSnapshot['date'],
          'userId': userSnapshot['id'],
          "time": timeSnapshot['time'],
          'case': reserveDoc['cases'],
          'caseDetails': reserveDoc['caseDetails'],
          'phoneNum': reserveDoc['phoneNum'],
          'lawyerName': lawyerName,
          'pepar':reserveDoc['pepar']
        };

        reservations.add(reservation);
      }
      yield reservations;
    }
  }

//-----------------------------------------------------------------------------------------------
  Future _replayDialog(String id, String userId, Map replayData) async {
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
                      "الأوراق المطلوبة",
                      style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w600,
                          color: Color(0xffcb4154)),
                    ),
                  )),
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 10, right: 10, left: 10),
                  child: TextField(
                    obscureText: false,
                    maxLines: 5,
                    controller: _replay,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      labelText: "اكتب الاوراق المطلوبة",
                      labelStyle: TextStyle(
                          color:
                              myFocusNode.hasFocus ? Colors.blue : Colors.grey),
                      fillColor: Colors.black54,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
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
                          Firestore.instance
                              .collection('Reserve')
                              .document(id)
                              .updateData({"pepar": _replay.text});
                          DocumentReference documentRef = Firestore.instance
                              .collection('notifiReplay')
                              .document();
                          documentRef.setData({
                        "view":false,
                            'notifiId': documentRef.documentID,
                            'reserveId': id,
                            "userId":userId,
                          
                          });
                          Navigator.of(context).pop();
                        },
                        color: Color(0xffcb4154),
                        textColor: Colors.white,
                        child: Text("ارسال",
                            style: TextStyle(
                              fontSize: 15.0,
                            )),
                      ),
                      SizedBox(
                        width: 20.0,
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
//-----------------------------------------------------------------------------------------------------------------
Widget build(BuildContext context) {

        var streamBuilder= StreamBuilder<List>(
         stream:getData() ,
         builder:(BuildContext context,AsyncSnapshot<List> reservationsSnapshot ){
           if(reservationsSnapshot.hasError){
             return Text("${reservationsSnapshot.error}");
           }
           if(reservationsSnapshot.hasData){
             return Scaffold(
         drawer: drawerprofile(currentUser: widget.user,),
                appBar: AppBar(title: new Text("مواعيد الحجوزات" ),), 
             body: Container(
          // padding:EdgeInsets.only(top:40),
          color:  Color(0xff0e243b),
          child: Stack(children: <Widget>[
            Column(children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 3,
                // width: 300.0,
                margin: EdgeInsets.only(right: 70.0),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(900.0)),
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
                padding:
                    EdgeInsets.only(right: 20, left: 20, bottom: 10, top: 70),

                    child: ListView(
                      children: reservationsSnapshot.data.map((doc){
                       
                        var x=DateTime.parse(doc['date'].toDate().toString());
                        var date=new DateFormat("MM-dd").format(x);
                        var day=_days[(x.weekday)-1];
                        var replayData = {
                            'case': doc['case'],
                            'lawyerName': doc['lawyerName'],
                          };
                        return Container(
                        margin: EdgeInsets.only(bottom: 20.0),
                        child: Column(children: <Widget>[
                          Container(
                              child: Container(

                                      //height: 250,
                                      width: 500,
                                      // margin:EdgeInsets.only(bottom:10.0) ,
                                      child: Stack(
                                        //  alignment: Alignment.topLeft,
                                        children: <Widget>[
                                          Container(
                                            //height: 160,
                                            width: 500,
                                            margin: EdgeInsets.only(top: 40.0),
                                            padding: EdgeInsets.only(
                                                top: 15.0, right: 5),
                                            decoration: BoxDecoration(
                                                color:  Color(0xff0e243b),
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(20.0),
                                                    topLeft:
                                                        Radius.circular(20.0)),
                                                border: Border.all(
                                                    color: Color(0xff69a5a5))),
                                            child: Column(
                                              children: <Widget>[
                                                Text("الاستاذ :${doc['userName']} ",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.white),
                                                ),
                                                 Text("تليفون :${doc['phoneNum']} ",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.white),
                                                ),
                                                Divider(
                                                  color: Colors.grey,
                                                ),
                                                Container(
                                                    child: Column(children: <Widget>[
                                                      Text(
                                                  "نوع القضية :${doc['case']}",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  "تفاصيل المشكلة :${doc['caseDetails']}",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.white),
                                                )
                                                    ],)),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                              width: 130.0,
                                              height: 60.0,
                                              child: Container(
                                                  padding: EdgeInsets.only(
                                                      right: 5, top: 5),
                                                  margin: EdgeInsets.only(
                                                      right: 5.0),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Color(0xff1bd0d0),
                                                        Color(0xff1bd0d0)
                                                      ],
                                                      begin:
                                                          Alignment.centerRight,
                                                      end:
                                                          Alignment(-1.0, -1.0),
                                                    ),
                                                  ),
                                                  child:
                                                      Column(children: <Widget>[
                                                    // Icon(Icons.calendar_today,color: Color(0xffe6a651),),
                                                    Text("${doc['time']}",
                                                        style: TextStyle(
                                                            color: Colors.red,
                                                            fontSize: 15.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600)),
                                                    Text("$day" +" "+" $date",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 15.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600))
                                                  ])))
                                        ],
                                      )),
                                  ),
                          Container(
                            // height:30.0,
                            decoration: BoxDecoration(
                                color:  Color(0xff0e243b),
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(20.0),
                                    bottomLeft: Radius.circular(20.0)),
                                border: Border.all(color: Color(0xff69a5a5))),
                            padding: EdgeInsets.only(left: 7),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      side:
                                          BorderSide(color: Color(0xffcb4154))),
                                  onPressed: () {
                                 //_cancelDialog(doc['id'],doc['timeId']);
                                   _replayDialog(doc['id'],doc['userId'], replayData);
                                  },
                                  color: Color(0xffcb4154),
                                  textColor: Colors.white,
                                  child: Text("رد",
                                      style: TextStyle(
                                        fontSize: 15.0,
                                      )),
                                ),
                                SizedBox(
                                  width: 10.0,
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

         }
         else{

           return Scaffold(body: Center(child:Text("انتظر قليلا....."),)
           );
         }
           });

         
         /*if (snapshot.hasData) {
           return */
      
    return streamBuilder;
  }
}

import 'package:badges/badges.dart';
import 'package:gpproject/Classes/User.dart';
import 'package:gpproject/Pages/CourtPages/addCase.dart';
import 'package:gpproject/Pages/CourtPages/manageCases.dart';
import 'package:gpproject/Classes/notification.dart';
import 'package:gpproject/Pages/questionPage.dart';
import 'package:gpproject/Pages/answerquestions.dart';
import 'package:gpproject/Pages/question_and_answer.dart';
import 'package:gpproject/Pages/question_list.dart';
import 'package:gpproject/models/archivedCases.dart';
import 'package:gpproject/models/user.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gpproject/Pages/CourtPages/addCase.dart';
import 'ProfileUsers.dart';
import 'clicky_button.dart';
import 'drawerprofile.dart';
import 'lawyer_list.dart';

import 'package:gpproject/Pages/CourtPages/view_archived_cases.dart';
class MainPage extends StatefulWidget {
  MainPage({Key key, this.title, this.user, this.currentUser });
  final FirebaseUser user;
  final String title;
  final FirebaseUser currentUser;
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  UserClass userClass = new UserClass();
  User user = new User();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
   final UserSnapshot = Firestore.instance;
  FirebaseUser firebaseUser;
  User currentUser = new User();


 NotificationClass noti = new NotificationClass();

  initUser() async {
    //firebaseUser = await _firebaseAuth.currentUser();
    //userID = firebaseUser.uid;
    currentUser = this.userClass.getCurrentUser();
    setState(() {});
  }

  User client = new User();
  ScrollController _scrollController = new ScrollController();
  final _formKey = GlobalKey<FormState>();
  Future _data;
  Future getClients() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore
        .collection("users")
        .where('role', isEqualTo: "1")
        .where('lawyerId', isEqualTo: widget.user.uid)
        .where('courtId', isEqualTo: widget.user.uid)
        .getDocuments();
    return qn.documents;
  }



  static Future<void> signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    FirebaseAuth.instance.signOut();
  }

  @override
  void initState() {
    super.initState();
    initUser();
    _data = getClients();
  }

  var m ;
void countDocumentLength() async {
    QuerySnapshot x = await Firestore.instance.collection("reading")
    .where("id", isEqualTo: widget.user.uid).getDocuments();
    List<DocumentSnapshot> _x = x.documents;
    m =_x.length;
  }

  var b ;
void countDocumentLengthAnswer() async {
    QuerySnapshot x = await Firestore.instance.collection("answers").
    where("id", isEqualTo: widget.user.uid).getDocuments();
    List<DocumentSnapshot> _x = x.documents;
    b =_x.length;
  }

  Color prime = Colors.red[800] ;
  Color second = Colors.white ;
   int _page = 0 ;
   
  @override
  Widget build(BuildContext context) {
    countDocumentLength();
    countDocumentLengthAnswer();

    return new  Scaffold(
        drawer: drawerprofile(currentUser: widget.user),
        appBar: AppBar(
          title: new Icon(Icons.home , size: 20.0, color: second ),
           ),
       body: StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance
              .collection('users')
              .document(widget.user.uid)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              return checkRole(snapshot.data);
            }
            return CircularProgressIndicator();
          },
        ),
    );
  }
  FutureBuilder checkRole(DocumentSnapshot snapshot) {
    if (snapshot.data == null) {
      return FutureBuilder(
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text(" ...من فضلك انتظر قليلا"),
            );
          } else {
            return new Text('no data set in the userId document in firestore');
          }
        },
      );
    }
    if (snapshot.data['role'] == '1') {
      return userPage(snapshot) ;

          } else if (snapshot.data['role'] == '2') {
            return createListView(snapshot);
          } else if (snapshot.data['role'] == '3'){
            return courtPage(snapshot);
          } 

        }    
        FutureBuilder userPage(DocumentSnapshot snapshot) {
          return FutureBuilder(
              future: _data ,
              builder: (_, snapshot) {
                 if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Text("Loading ..."),
                  );
                } else {
                return new  Column(
                          children: <Widget>[
      
                             new  BottomNavigationBar(
                       currentIndex: _page,
                         items: [
                            BottomNavigationBarItem(
                             backgroundColor: prime,
                             icon: new Icon(Icons.person , color: second,),
                             title: new Text('الصفحة الشخصية' , style: new TextStyle(fontSize: 10.0 , color: second),)
                           ),
                           BottomNavigationBarItem(
                             backgroundColor: prime,
                             icon: new Icon(Icons.help , color: second,),
                             title: new Text('أسال الان؟' , style: new TextStyle(fontSize: 10.0 , color: second),)
                           ),

                           BottomNavigationBarItem(
                        backgroundColor: prime,
                         icon : new Badge(
                         animationType: BadgeAnimationType.slide,
                         badgeContent:  Text("$b"),
                       child: new Icon(Icons.question_answer , color: second,)),
                       title: new Text('الجواب' , style: new TextStyle(fontSize: 10.0 , color: second),)
                     ),
                           BottomNavigationBarItem(
                             backgroundColor: prime,
                             icon: new Icon(Icons.notifications_none , color: second,),
                             title: new Text('الاشعارات' , style: new TextStyle(fontSize: 10.0 , color: second),)
                           ),
                         ],
                          onTap: (index){
                   setState(() {
                     _page = index ; 
                    if(_page == 0){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => profileUsers( currentUser: widget.user,)));             
                    }else if (_page == 1){
                   Navigator.push(context,MaterialPageRoute(builder: (context) =>  LawyerList(value: widget.user)));
                    }else if (_page == 2){
                          Navigator.push(context,  MaterialPageRoute(builder: (context) => QuestionAndAnswer(value: widget.user.uid, v: widget.user)));
                        Firestore.instance.collection("answers").where("id", isEqualTo: widget.user.uid).getDocuments().then((snapshot)
                        {for (DocumentSnapshot ds in snapshot.documents){ds.reference.delete();}});                

                    }else if (_page == 3){
                          Navigator.push(context,  MaterialPageRoute(builder: (context) => questionPage()));
                    }
                   });
                  },
                  ),
                 new Container(
                          child: Padding(
                          padding: EdgeInsets.only(
                              top: 30.0, bottom: 0.0, right: 10.0, left: 10.0),
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                     decoration: BoxDecoration(
                          border: Border.all(color: Colors.teal[900]),
                          borderRadius: BorderRadius.all(Radius.elliptical(30, 30)),
                          color: Colors.white70,
                        ),
                        margin: EdgeInsets.fromLTRB(20, 0, 20, 50),
                        padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                        child: new TextField(
                          style: TextStyle(),
                          textDirection: TextDirection.rtl,
                          autocorrect: true,
                          decoration: new InputDecoration(
                            border: InputBorder.none,
                            icon: new IconButton(
                                icon: new Icon(Icons.search), onPressed: null),
                            hintText: "ابحث عن رأي القانون في مشكلتك",
                          ),
                        )
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                ]
              );
                }
      
              });
        }
        FutureBuilder createListView(DocumentSnapshot snapshot) {
          return FutureBuilder(
              future: _data,
              builder: (_, snapshot) {
              //  _gettapbar1();
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Text(" من فضلك انتظر قليلا... "),
                  );
                } else {
                  return ListView(
                    children: <Widget>[
                       new  BottomNavigationBar(
                         backgroundColor: prime,
                       currentIndex: _page,
                         items: [
                            BottomNavigationBarItem(
                             backgroundColor: prime,
                             icon: new Icon(Icons.person , color: second,),
                             title: new Text('الصفحة الشخصية' , style: new TextStyle(fontSize: 10.0 , color: second),)
                           ),

                           BottomNavigationBarItem(
                         icon : new Badge(
                         animationType: BadgeAnimationType.slide,
                         badgeContent:  Text("$m"),
                         child: new Icon(Icons.question_answer , color: second, ),),
                         title: new Text('الجواب' , style: new TextStyle(fontSize: 10.0 , color: second),)
                     ),

                           BottomNavigationBarItem(
                             backgroundColor: prime,
                             icon: new Icon(Icons.notifications_none , color: second,),
                             title: new Text('الاشعارات' , style: new TextStyle(fontSize: 10.0 , color: second),)
                           ),
                         ],
                          onTap: (index){
                   setState(() {
                     _page = index ; 
                    if(_page == 0){
                     Navigator.push(context, MaterialPageRoute(builder: (context) => profileUsers(currentUser: widget.user,)));             
                    }else if (_page == 1){
                           Navigator.push(context,MaterialPageRoute(builder: (context) => QuestionList(value : widget.user.uid, v :widget.user)));
                           Firestore.instance.collection("reading").where("id", isEqualTo: widget.user.uid).getDocuments().then((snapshot)
                           {for (DocumentSnapshot ds in snapshot.documents){ds.reference.delete();}});

                    }else if (_page == 2){
                         Navigator.push(context,MaterialPageRoute(builder: (context) => questionPage()));
                    }
                   });
                  },
                  ),
                      Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("image/law.jpg"),
                                fit: BoxFit.cover)),
                        child: Column(children: <Widget>[
                          new Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color.fromARGB(250, 46, 47, 31),
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.elliptical(30, 30)),
                                color: Color.fromARGB(100, 225, 225, 225)
                                    .withOpacity(0.3),
                              ),
                              margin: EdgeInsets.fromLTRB(20, 100, 20, 50),
                              padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                              child: new TextField(
                                style: TextStyle(),
                                textDirection: TextDirection.rtl,
                                autocorrect: true,
                                decoration: new InputDecoration(
                                  border: InputBorder.none,
                                  icon: new IconButton(
                                      icon: new Icon(Icons.search), onPressed: null),
                                ),
                              )),
                          new Container(
                              margin: EdgeInsets.fromLTRB(20, 10, 20, 30),
                              //  padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                              child: CarouselSlider(
                                height: (MediaQuery.of(context).size.height) / 3,
                                aspectRatio: 16 / 9,
                                viewportFraction: 0.8,
                                initialPage: 0,
                                enableInfiniteScroll: true,
                                reverse: false,
                                //autoPlay: true,
                                autoPlayInterval: Duration(seconds: 3),
                                autoPlayAnimationDuration:
                                    Duration(milliseconds: 800),
                                autoPlayCurve: Curves.linear,
                                pauseAutoPlayOnTouch: Duration(seconds: 10),
                                enlargeCenterPage: true,
                                scrollDirection: Axis.horizontal,
                                items: [1, 2, 3, 4, 5].map((i) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return Container(
                                          width: MediaQuery.of(context).size.width,
                                          margin:
                                              EdgeInsets.symmetric(horizontal: 3.0),
                                          decoration: BoxDecoration(
                                            color: Color.fromARGB(100, 225, 225, 225)
                                                .withOpacity(0.3),
                                            borderRadius: BorderRadius.all(
                                                Radius.elliptical(30, 30)),
                                          ),
                                          child: Text(
                                            ' عنوان $i',
                                            style: TextStyle(fontSize: 16.0),
                                          ));
                                    },
                                  );
                                }).toList(),
                              )),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Material(
                                type: MaterialType.transparency,
                                child: new FloatingActionButton(
                                  onPressed: () {},
                                  child: new Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  backgroundColor: Color.fromARGB(250, 46, 47, 31),
                                )),
                          )
                        ]),
                      ),
                    ],
                  );
                }
              });
        }

//---------------------------- COURT PAGE   -------------------------------------
        FutureBuilder courtPage(DocumentSnapshot snapshot) {
          return FutureBuilder(
              future: _data,
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Text(" من فضلك انتظر قليلا... "),
                  );
                } else {
                  return Column(
                    children: <Widget>[
                       new  BottomNavigationBar(
                         backgroundColor: prime,
                       currentIndex: _page,
                         items: [
                            BottomNavigationBarItem(
                             backgroundColor: prime,
                             icon: new Icon(Icons.perm_identity , color: second,),
                             title: new Text('الصفحة الشخصية' , style: new TextStyle(fontSize: 10.0 , color: second),)
                           ),
                            BottomNavigationBarItem(
                             backgroundColor: prime,
                             icon:  new Icon(Icons.archive , color: second,),
                             title: new Text('الارشيف' , style: new TextStyle(fontSize: 10.0 , color: second),)
                           ),
                           BottomNavigationBarItem(
                             backgroundColor: prime,
                             icon: new Icon(Icons.notifications_none , color: second,),
                             title: new Text('الاشعارات' , style: new TextStyle(fontSize: 10.0 , color: second),)
                           ),
                         ],
                          onTap: (index){
                   setState(() {
                     _page = index ; 
                    if(_page == 0){

                      Navigator.push(context, MaterialPageRoute(builder: (context) => profileUsers(currentUser: widget.user,)));             

                    }else if (_page == 1){
                    Navigator.push(context,MaterialPageRoute(builder: (context) => view_archived_cases(currentCourt: widget.user)));
                    }else if (_page == 2){
                         Navigator.push(context,MaterialPageRoute(builder: (context) => questionPage()));
                    }
                   });
                  },
                  ),
                     //-----------------------------SEARCH ----------------------------
                      new Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.brown),
                            borderRadius: BorderRadius.all(Radius.elliptical(30, 30)),
                            color: Colors.white70,
                          ),
                          margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                          padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                          child: new TextField(
                            style: TextStyle(),
                            textDirection: TextDirection.rtl,
                            autocorrect: true,
                            decoration: new InputDecoration(
                              border: InputBorder.none,
                              icon: new IconButton(
                                  icon: new Icon(Icons.search), onPressed: null),
                              hintText: "ابحث عن اسم أو رقم تسلسل القاضية ",
                            ),
                          )),
      //------------------------2 big buttons---------------------------------
      //----------------------FIRST BUTTON
                    Container(
                     child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new CircleAvatar(
                    backgroundColor: prime , 
                    maxRadius: 87.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.add_circle,
                            color: second,
                            size: 35,
                          ),
                          onPressed: () {
                            Navigator.push(context,new MaterialPageRoute(
                                builder:(context)=>addCase(currentCourt:widget.user,)
                            ));
                          },
                        ),
                        new SizedBox(
                          height: 3.0,
                        ),
                        new Text("اضافة قضيه", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: second),),
                      ],
                    ),
                  ),
                ],
              ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(bottom:25),
                    ),
                    //---------------------------SECOND BUTTON---------------
                    Container(
                       child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new CircleAvatar(
                    backgroundColor:  prime,
                    maxRadius: 87.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.settings,
                            color: second,
                            size: 35,
                          ),
                          onPressed: () {
                             Navigator.push(
                               context,new MaterialPageRoute(builder:(context)=>manageCases(currentCourt:widget.user )));
                          },
                        ),
                        new SizedBox(
                          height: 3.0,
                        ),
                        new Text("ادارة القضايا الحاليه",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                      ],
                    ),
                  ),
                ],
              ),
                    )
                    ],
                  );
                }
              });
        }

    }


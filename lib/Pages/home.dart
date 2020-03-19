import 'package:gpproject/Classes/User.dart';
import 'package:gpproject/Pages/questionPage.dart';
import 'package:gpproject/Pages/userProfile.dart';
import 'package:gpproject/Pages/lawyerquestion.dart';
import 'package:gpproject/Pages/answerquestion.dart';
import 'package:gpproject/models/user.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'clicky_button.dart';
import 'drawerprofile.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title, this.user, this.currentUser});
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
  FirebaseUser firebaseUser;
  User currentUser = new User();

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
        .where('lawyerid', isEqualTo: widget.user.uid)
        .where('courtId', isEqualTo: widget.user.uid)
        .getDocuments();
    return qn.documents;
  }

  navigateToDetail(DocumentSnapshot user) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FbCprofileState(user: user)),
    );
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

  Future<void> _gettapbar() async {
    return new DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: drawerprofile(currentUser: widget.user),
        appBar: AppBar(
          shape: CustomShapeBorder(),
          backgroundColor: Colors.cyan,
          bottom: new TabBar(
            tabs: [
              Tab(
                  child: IconButton(
                icon: new Icon(
                  Icons.person,
                ),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FbCprofileState(
                              currentuser: widget.currentUser,
                            ))),
                iconSize: 30,
              )),
              Tab(
                child: IconButton(
                  // padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                  icon: new Icon(Icons.question_answer),
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => questionPage())),
                  iconSize: 30,
                ),
              ),

              Tab(
                child: IconButton(
                  // padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                  icon: new Icon(Icons.notifications_none),
                  onPressed: () {},
                  iconSize: 30,
                ),
              ),
            ],
            indicatorColor: Colors.white,
          ),
        ),
        body: new TabBarView(
          children: <Widget>[
            new FbCprofileState(
              currentuser: widget.currentUser,
            ),
            new questionPage(),
            // new questionPage(),
            new questionPage(),
          ],
        ),
      ),
      // ),
    );
  }

  Future<void> _gettapbar1() async {
    return new DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: drawerprofile(currentUser: widget.user),
        appBar: AppBar(
          shape: CustomShapeBorder(),
          backgroundColor: Colors.cyan,
          bottom: new TabBar(
            tabs: [
              Tab(
                  child: IconButton(
                icon: new Icon(
                  Icons.person,
                ),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FbCprofileState(
                              currentuser: widget.currentUser,
                            ))),
                iconSize: 30,
              )),
              Tab(
                child: IconButton(
                  // padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                  icon: new Icon(Icons.question_answer),
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => questionPage())),
                  iconSize: 30,
                ),
              ),
              Tab(
                child: IconButton(
                  // padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                  icon: new Icon(Icons.notifications_none),
                  onPressed: () {},
                  iconSize: 30,
                ),
              ),
            ],
            indicatorColor: Colors.white,
          ),
        ),
        body: new TabBarView(
          children: <Widget>[
            new FbCprofileState(
              currentuser: widget.currentUser,
            ),
            new questionPage(),
            //  new questionPage(),
            new questionPage(),
          ],
        ),
      ),
      // ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: drawerprofile(currentUser: widget.user),
        appBar: AppBar(
          shape: CustomShapeBorder(),
          backgroundColor: Colors.cyan,
          bottom: new TabBar(
            tabs: [
              Tab(
                  child: IconButton(
                icon: new Icon(
                  Icons.person,
                ),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FbCprofileState(
                              currentuser: widget.currentUser,
                            ))),
                iconSize: 30,
              )),
              Tab(
                child: IconButton(
                  icon: new Icon(Icons.question_answer),
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => questionPage())),
                  iconSize: 30,
                ),
              ),
              Tab(
                child: IconButton(
                  icon: new Icon(Icons.notifications_none),
                  onPressed: () {},
                  iconSize: 30,
                ),
              ),
            ],
            indicatorColor: Colors.white,
          ),
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
            return LinearProgressIndicator();
          },
        ),
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
      return userPage(snapshot);
    } else if (snapshot.data['role'] == '2') {
      return createListView(snapshot);
      //return lawyerPage(snapshot);
    } else {
      return courtPage(snapshot);
    }
  }
  FutureBuilder userPage(DocumentSnapshot snapshot) {
    return FutureBuilder(
        future: _data,
        builder: (_, snapshot) {
          _gettapbar();
          return ListView(
            children: <Widget>[
              new Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.teal[900]),
                    borderRadius: BorderRadius.all(Radius.elliptical(30, 30)),
                    color: Colors.white70,
                  ),
                  margin: EdgeInsets.fromLTRB(20, 80, 20, 50),
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
                  )),
            ],
          );
          //}
        });
  }
  FutureBuilder createListView(DocumentSnapshot snapshot) {
    return FutureBuilder(
        future: _data,
        builder: (_, snapshot) {
          _gettapbar1();
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text(" من فضلك انتظر قليلا... "),
            );
          } else {
            return Column(
              children: <Widget>[
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
                new Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.brown),
                      borderRadius: BorderRadius.all(Radius.elliptical(30, 30)),
                      color: Colors.white70,
                    ),
                    margin: EdgeInsets.fromLTRB(20, 80, 20, 50),
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
                Container(
                  height: 90,
                  margin: EdgeInsets.fromLTRB(0, 5, 5, 0),
                  child: new Stack(
                    children: <Widget>[
                      new Container(
                        height: 124,
                        margin: const EdgeInsets.only(left: 46),
                        // child: Text("الاسم", textDirection: TextDirection.rtl,),
                        decoration: new BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25.0),
                            bottomRight: Radius.circular(25.0),
                            bottomLeft: Radius.circular(25.0),
                          ),
                        ),
                      ),
                      new Container(
                          height: 120,
                          width: 120,
                          margin: EdgeInsets.fromLTRB(20, 10, 180, 0),
                          // margin:  EdgeInsets.symmetric(  horizontal: 20,vertical: 20 ,),
                          alignment: FractionalOffset.centerLeft,
                          child: new CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.transparent,
                            backgroundImage: NetworkImage(
                                "http://photo.elcinema.com.s3.amazonaws.com/uploads/_315x420_af94736653749ad01096cd6e2757e6489a8750dc5334bb6a0bb9cf8e428d4cc0.jpg"),
                          )),
                      new Positioned(
                        right: 10,
                        bottom: 25,
                        child: IconButton(
                            iconSize: 30,
                            icon: Icon(
                              Icons.more,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (_) => Stack(children: <Widget>[
                                        AlertDialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          content: SingleChildScrollView(
                                              child:
                                                  ListBody(children: <Widget>[
                                            new Text(
                                              'الاسم',
                                              textAlign: TextAlign.right,
                                              textDirection: TextDirection.rtl,
                                            ),
                                            new Text(
                                              'رقم التسلسل',
                                              textAlign: TextAlign.right,
                                              textDirection: TextDirection.rtl,
                                            ),
                                            new Text(
                                              'عنوان المكتب',
                                              textAlign: TextAlign.right,
                                              textDirection: TextDirection.rtl,
                                            ),
                                            new Text(
                                              'عنوانه الخاص',
                                              textAlign: TextAlign.right,
                                              textDirection: TextDirection.rtl,
                                            ),
                                            new Text(
                                              'رقم الهاتف',
                                              textAlign: TextAlign.right,
                                              textDirection: TextDirection.rtl,
                                            ),
                                            new Text(
                                              'رقم البطاقة',
                                              textAlign: TextAlign.right,
                                              textDirection: TextDirection.rtl,
                                            ),
                                            new Text(
                                              'رقم كارنية النقابة',
                                              textAlign: TextAlign.right,
                                              textDirection: TextDirection.rtl,
                                            ),
                                          ])),
                                          actions: <Widget>[
                                            Transform.scale(
                                              alignment: Alignment.bottomCenter,
                                              scale: 0.5,
                                              child: ClickyButton(
                                                child: Text(
                                                  'تعديل',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 35),
                                                ),
                                                color: Colors.green,
                                                onPressed: () {},
                                              ),
                                            ),
                                          ],
                                        ),
                                        Positioned(
                                            left: 126,
                                            top: 35,
                                            child: new CircleAvatar(
                                              radius: 50,
                                              backgroundImage: NetworkImage(
                                                  "http://photo.elcinema.com.s3.amazonaws.com/uploads/_315x420_af94736653749ad01096cd6e2757e6489a8750dc5334bb6a0bb9cf8e428d4cc0.jpg"),
                                              backgroundColor:
                                                  Colors.transparent,

                                              // backgroundColor: Colors.white,
                                            ))
                                      ]));
                            }),
                      ),
                      new Positioned(
                          right: 65,
                          bottom: 50,
                          child: Text(
                            ":الاسم",
                            style:
                                TextStyle(fontSize: 20, color: Colors.black54),
                          )),
                      new Positioned(
                          right: 65,
                          bottom: 10,
                          child: Text(
                            ":رقم التسلسل",
                            style:
                                TextStyle(fontSize: 20, color: Colors.black54),
                          )),
                    ],
                  ),
                )
              ],
            );
          }
        });
  }
}
class CustomShapeBorder extends ContinuousRectangleBorder {
  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    final double innerCircleRadius = 130.0;

    Path path = Path();
    path.lineTo(0, rect.height);
    path.quadraticBezierTo(rect.width / 2 - (innerCircleRadius / 2) - 30,
        rect.height + 15, rect.width / 2 - 75, rect.height + 50);
    path.cubicTo(
        rect.width / 2 - 40,
        rect.height + innerCircleRadius - 40,
        rect.width / 2 + 40,
        rect.height + innerCircleRadius - 40,
        rect.width / 2 + 75,
        rect.height + 50);
    path.quadraticBezierTo(rect.width / 2 + (innerCircleRadius / 2) + 30,
        rect.height + 15, rect.width, rect.height);
    path.lineTo(rect.width, 0.0);
    path.close();

    return path;
  }
}

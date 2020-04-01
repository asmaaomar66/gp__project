import 'package:gpproject/Classes/User.dart';
import 'package:gpproject/Pages/ProfileUsers.dart';
import 'package:gpproject/Pages/drawerprofile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gpproject/models/court.dart';
import 'package:gpproject/models/lawyer.dart';
import 'package:gpproject/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toast/toast.dart';

class profileEdit extends StatefulWidget {
  profileEdit({this.currentUser}) ;
  final FirebaseUser currentUser;

  @override
  profileEditState createState() => profileEditState();
}

class profileEditState extends State<profileEdit>  {
  var userID;
  ScrollController _scrollController = new ScrollController();
  User _user = new User();
  Lawyer _lawyer = new Lawyer() ;
  Court _court = new Court();
  UserClass userClass = new UserClass();
  final _formKey = GlobalKey<FormState>();
   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;

  static Future<void> signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    FirebaseAuth.instance.signOut();
  }
  Color prime = Color(0xff0e243b);
  Color second = Colors.white ;
  Color third =  Color(0xff0ccaee) ;
@override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      drawer: drawerprofile(currentUser: widget.currentUser),
      appBar:   new AppBar(
                      backgroundColor: prime,
                      title: Text('تعديل',
                                style: TextStyle(
                                color: second,
                                 ),
                                  ),
                                 
                                ),
      body:  StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance
            .collection("users")
            .document(widget.currentUser.uid)
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
    );
  }
 Widget checkRole(DocumentSnapshot snapshot) {
    if (snapshot.data == null) {
      return StreamBuilder<DocumentSnapshot>(
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
      return userEditProfile(snapshot) ;
                } 
                else if (snapshot.data['role'] == '2') {
                  return lawyerEditProfile(snapshot);
                                  
                                  } else {
                                    return courtEditProfile(snapshot);
                                  }
                                }
                        
                          Widget userEditProfile(DocumentSnapshot snapshot) {
                             Firestore firebaseref = Firestore.instance;
                             CollectionReference usersRef = firebaseref.collection("users");
                            return  Form(
                                       key: _formKey,
                                       child: ListView(
                                        controller: _scrollController,
                                          children: <Widget>[
                                             Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                                 children: <Widget>[
                                                 Container(
                                                        margin: EdgeInsets.only(top: 20.0),
                                                        width: 100.0,
                                                        height: 100.0,
                                                        decoration: BoxDecoration(
                                                          color: third,
                                                          //image here
                                                          image: DecorationImage(
                                                         image: NetworkImage( '${snapshot.data['image']}' ),
                                                         fit: BoxFit.fill),
                                                          borderRadius:
                                                              BorderRadius.all(Radius.circular(75.0)),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(10.0),
                                                    child: TextFormField(
                                                      initialValue: '${snapshot.data['fname']}',
                                                      style: TextStyle(
                                                        fontSize: 18.0,
                                                      ),
                                                      onSaved: (input) => _user.fname = input,
                                                      decoration: InputDecoration(
                                                           hintText: "ادخل الاسم الاول", 
                                                          hintStyle: TextStyle(
                                                            color: third,
                                                            fontSize: 18,
                                                          ),
                                                          contentPadding:
                                                              EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                                              border: OutlineInputBorder(
                                                              borderRadius: BorderRadius.circular(10.0)),
                                                          ),
                                                      validator: (value) {
                                                        if (value.isEmpty) {
                                                          _user.fname = '${snapshot.data['fname']}';
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(10.0),
                                                    child: TextFormField(
                                                      initialValue: '${snapshot.data['lname']}',
                                                      style: TextStyle(
                                                        fontSize: 18.0,
                                                      ),
                                                      onSaved: (input) => _user.lname = input,
                                                      decoration: InputDecoration(
                                                         hintText: "إدخل اسم العائلة", 
                                                          hintStyle: TextStyle(
                                                            color: third,
                                                            fontSize: 18,
                                                          ),
                                                          contentPadding:
                                                              EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                                              border: OutlineInputBorder(
                                                              borderRadius: BorderRadius.circular(10.0)),
                                                      ),
                                                      validator: (value) {
                                                        if (value.isEmpty) {
                                                          _user.lname = _user.lname;
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(10.0),
                                                    child: TextFormField(
                                                      initialValue: '${snapshot.data['username']}',
                                                      style: TextStyle(
                                                        fontSize: 18.0,
                                                      ),
                                                      onSaved: (input) => _user.username = input,
                                                      decoration: InputDecoration(
                                                         hintText: "إدخل اسم المستخدم", 
                                                          hintStyle: TextStyle(
                                                            color: third,
                                                            fontSize: 18,
                                                          ),
                                                          contentPadding:
                                                              EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                                              border: OutlineInputBorder(
                                                              borderRadius: BorderRadius.circular(10.0)),
                                                              
                                                      ),
                                                      validator: (value) {
                                                        if (value.isEmpty) {
                                                          _user.username = _user.username;
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(10.0),
                                                    child: TextFormField(
                                                      initialValue: '${snapshot.data['phone']}',
                                                      style: TextStyle(
                                                        fontSize: 18.0,
                                                      ),
                                                      onSaved: (input) => _user.phone = input,
                                                      decoration: InputDecoration(
                                                         hintText: "إدخل رقم الهاتف", 
                                                        hintStyle: TextStyle(
                                                          color: third,
                                                          fontSize: 18,
                                                        ),
                                                        contentPadding:
                                                            EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                                            border: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(10.0)),
                                                        prefixIcon: Icon(
                                                          Icons.phone,
                                                          color: third,
                                                          size: 32.0,
                                                        ),
                                                      ),
                                                      validator: (value) {
                                                        if (value.isEmpty) {
                                                          _user.phone = '${snapshot.data['phone']}';
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(10.0),
                                                    child: TextFormField(
                                                      initialValue: '${snapshot.data['email']}',
                                                      style: TextStyle(
                                                        fontSize: 18.0,
                                                      ),
                                                      onSaved: (input) => _user.email = input,
                                                      decoration: InputDecoration(
                                                         hintText: "إدخل البريد الالكتروني", 
                                                        hintStyle: TextStyle(
                                                          color: third,
                                                          fontSize: 18,
                                                        ),
                                                        contentPadding:
                                                            EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                                            border: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(10.0)),
                                                        prefixIcon: Icon(
                                                          Icons.mail,
                                                          color: third,
                                                          size: 32.0,
                                                        ),
                                                      ),
                                                      validator: (value) {
                                                        if (value.isEmpty) {
                                                          _user.email = '${snapshot.data['email']}';
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ),
                                               
                                                 
                                                  Container(
                                                    padding: const EdgeInsets.all(10.0),
                                                    child: FloatingActionButton(
                                                      onPressed: () async{
                                                        firebaseUser = await _firebaseAuth.currentUser();
                                                        var userID = firebaseUser.uid;
                                                        EmailAuthProvider.getCredential(email: 'email', password: 'password');

                                                        if (_formKey.currentState.validate()) {
                                                          _formKey.currentState.save();
                                                          print(_user.email);
                                                          firebaseUser.updateEmail(_user.email);
                                                            usersRef.document(userID).updateData({
                                                            "fname": _user.fname,
                                                            "lname": _user.lname,
                                                            "username": _user.username,
                                                            "email": _user.email,
                                                            "phone": _user.phone,
                                                          }).then((data) {
                                                            print("تم");
                                                            // print(data);
                                                            Toast.show("تم التعديل بنجاح", context);
                                                             Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => profileUsers(
                                                                        currentUser: widget.currentUser,
                                                                      )));
                                                          }).catchError((err) {
                                                            print(err);
                                                            Toast.show("Error :" + err.toString(), context);
                                                          });
                                                        }
                                                         },
                                                      child: Text('حفظ'),
                                                      backgroundColor: third,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                           
                          }
                            Widget lawyerEditProfile(DocumentSnapshot snapshot) {
                            Firestore firebaseref = Firestore.instance;
                             CollectionReference usersRef = firebaseref.collection("users");
                            return  Form(
                                       key: _formKey,
                                       child: ListView(
                                        controller: _scrollController,
                                          children: <Widget>[
                                             Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                                 children: <Widget>[
                                                 Container(
                                                        margin: EdgeInsets.only(top: 20.0),
                                                        width: 100.0,
                                                        height: 100.0,
                                                        decoration: BoxDecoration(
                                                          color: third,
                                                          //image here
                                                          image: DecorationImage(
                                                         image: NetworkImage( '${snapshot.data['image']}' ),
                                                         fit: BoxFit.fill),
                                                          borderRadius:
                                                              BorderRadius.all(Radius.circular(75.0)),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(10.0),
                                                    child: TextFormField(
                                                      initialValue: '${snapshot.data['fname']}',
                                                      style: TextStyle(
                                                        fontSize: 18.0,
                                                      ),
                                                      onSaved: (input) => _lawyer.fname = input,
                                                      decoration: InputDecoration(
                                                           hintText: "ادخل الاسم الاول", 
                                                          hintStyle: TextStyle(
                                                            color: third,
                                                            fontSize: 18,
                                                          ),
                                                          contentPadding:
                                                              EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                                              border: OutlineInputBorder(
                                                              borderRadius: BorderRadius.circular(10.0)),
                                                          ),
                                                      validator: (value) {
                                                        if (value.isEmpty) {
                                                          _lawyer.fname = '${snapshot.data['fname']}';
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(10.0),
                                                    child: TextFormField(
                                                      initialValue: '${snapshot.data['lname']}',
                                                      style: TextStyle(
                                                        fontSize: 18.0,
                                                      ),
                                                      onSaved: (input) => _lawyer.lname = input,
                                                      decoration: InputDecoration(
                                                         hintText: "إدخل اسم العائلة", 
                                                          hintStyle: TextStyle(
                                                            color: third,
                                                            fontSize: 18,
                                                          ),
                                                          contentPadding:
                                                              EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                                              border: OutlineInputBorder(
                                                              borderRadius: BorderRadius.circular(10.0)),
                                                      ),
                                                      validator: (value) {
                                                        if (value.isEmpty) {
                                                          _lawyer.lname = _lawyer.lname;
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(10.0),
                                                    child: TextFormField(
                                                      initialValue: '${snapshot.data['username']}',
                                                      style: TextStyle(
                                                        fontSize: 18.0,
                                                      ),
                                                      onSaved: (input) => _lawyer.username = input,
                                                      decoration: InputDecoration(
                                                         hintText: "إدخل اسم المستخدم", 
                                                          hintStyle: TextStyle(
                                                            color: third,
                                                            fontSize: 18,
                                                          ),
                                                          contentPadding:
                                                              EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                                              border: OutlineInputBorder(
                                                              borderRadius: BorderRadius.circular(10.0)),
                                                      ),
                                                      validator: (value) {
                                                        if (value.isEmpty) {
                                                          _lawyer.username = _lawyer.username;
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(10.0),
                                                    child: TextFormField(
                                                      initialValue: '${snapshot.data['phone']}',
                                                      style: TextStyle(
                                                        fontSize: 18.0,
                                                      ),
                                                      onSaved: (input) => _lawyer.phone = input,
                                                      decoration: InputDecoration(
                                                         hintText: "إدخل رقم الهاتف", 
                                                        hintStyle: TextStyle(
                                                          color: third,
                                                          fontSize: 18,
                                                        ),
                                                        contentPadding:
                                                            EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                                            border: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(10.0)),
                                                        prefixIcon: Icon(
                                                          Icons.phone_android,
                                                          color: third,
                                                          size: 32.0,
                                                        ),
                                                      ),
                                                      validator: (value) {
                                                        if (value.isEmpty) {
                                                          _lawyer.phone = '${snapshot.data['phone']}';
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(10.0),
                                                    child: TextFormField(
                                                      initialValue: '${snapshot.data['email']}',
                                                      style: TextStyle(
                                                        fontSize: 18.0,
                                                      ),
                                                      onSaved: (input) => _lawyer.email = input,
                                                      decoration: InputDecoration(
                                                         hintText: "إدخل البريد الالكتروني", 
                                                        hintStyle: TextStyle(
                                                          color: third,
                                                          fontSize: 18,
                                                        ),
                                                        contentPadding:
                                                            EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                                            border: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(10.0)),
                                                        prefixIcon: Icon(
                                                          Icons.mail,
                                                          color: third,
                                                          size: 32.0,
                                                        ),
                                                      ),
                                                      validator: (value) {
                                                        if (value.isEmpty) {
                                                          _lawyer.email = '${snapshot.data['email']}';
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(10.0),
                                                    child: TextFormField(
                                                      initialValue: '${snapshot.data['personaladdress']}',
                                                      style: TextStyle(
                                                        fontSize: 18.0,
                                                      ),
                                                      onSaved: (input) => _lawyer.personaladdress = input,
                                                      decoration: InputDecoration(
                                                         hintText: "إدخل العنوان الشخصي", 
                                                              hintStyle: TextStyle(
                                                                color: third,
                                                                fontSize: 18,
                                                              ),
                                                              contentPadding:
                                                                  EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                                                  border: OutlineInputBorder(
                                                                  borderRadius: BorderRadius.circular(10.0)),
                                                        prefixIcon: Icon(
                                                          Icons.location_on,
                                                          color: third,
                                                          size: 32.0,
                                                        ),
                                                      ),
                                                      validator: (value) {
                                                        if (value.isEmpty) {
                                                          _lawyer.personaladdress = '${snapshot.data['personaladdress']}';
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(10.0),
                                                    child: TextFormField(
                                                      initialValue: '${snapshot.data['officeaddress']}',
                                                      style: TextStyle(
                                                        fontSize: 18.0,
                                                      ),
                                                      onSaved: (input) => _lawyer.officeaddress = input,
                                                      decoration: InputDecoration(
                                                         hintText: "إدخل عنوان المكتب", 
                                                              hintStyle: TextStyle(
                                                                color: third,
                                                                fontSize: 18,
                                                              ),
                                                              contentPadding:
                                                                  EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                                                  border: OutlineInputBorder(
                                                                  borderRadius: BorderRadius.circular(10.0)),
                                                        prefixIcon: Icon(
                                                          Icons.location_city,
                                                          color: third,
                                                          size: 32.0,
                                                        ),
                                                      ),
                                                      validator: (value) {
                                                        if (value.isEmpty) {
                                                          _lawyer.officeaddress = '${snapshot.data['officeaddress']}';
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(10.0),
                                                    child: TextFormField(
                                                      initialValue: '${snapshot.data['officenumber']}',
                                                      style: TextStyle(
                                                        fontSize: 18.0,
                                                      ),
                                                      onSaved: (input) => _lawyer.officenumber = input,
                                                      decoration: InputDecoration(
                                                         hintText: "إدخل رقم المكتب", 
                                                              hintStyle: TextStyle(
                                                                color: third,
                                                                fontSize: 18,
                                                              ),
                                                              contentPadding:
                                                                  EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                                                  border: OutlineInputBorder(
                                                                  borderRadius: BorderRadius.circular(10.0)),
                                                        prefixIcon: Icon(
                                                          Icons.phone,
                                                          color: third,
                                                          size: 32.0,
                                                        ),
                                                      ),
                                                      validator: (value) {
                                                        if (value.isEmpty) {
                                                          _lawyer.officenumber = '${snapshot.data['officenumber']}';
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ),
                                                
                                            
                                                  Container(
                                                    padding: const EdgeInsets.all(10.0),
                                                    child: FloatingActionButton(
                                                      onPressed: () async{
                                                         firebaseUser = await _firebaseAuth.currentUser();
                                                        var userID = firebaseUser.uid;
                                                       
                                                        if (_formKey.currentState.validate()) {
                                                           
                                                          _formKey.currentState.save();
                                                          print(_lawyer.email);
                                                          EmailAuthProvider.getCredential(email: 'email', password: 'password');
                                                           firebaseUser.updateEmail(_user.email);
                                                            usersRef.document(userID).updateData({
                                                            "fname": _lawyer.fname,
                                                            "lname": _lawyer.lname,
                                                            "username": _lawyer.username,
                                                            "email": _lawyer.email,
                                                            "phone": _lawyer.phone,
                                                            "personaladdress": _lawyer.personaladdress,
                                                            "officeaddress": _lawyer.officeaddress,
                                                            "officenumber": _lawyer.officenumber,
                                                          }).then((data) {
                                                            print("تم");
                                                            // print(data);
                                                            Toast.show("تم التعديل بنجاح", context);
                                                             Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => profileUsers(
                                                                        currentUser: widget.currentUser,
                                                                      )));
                                                          }).catchError((err) {
                                                            print(err);
                                                            Toast.show("Error :" + err.toString(), context);
                                                          });
                                                        }
                                                         },
                                                      child: Text('حفظ'),
                                                      backgroundColor: third,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                          }
                            Widget courtEditProfile(DocumentSnapshot snapshot) {
                             Firestore firebaseref = Firestore.instance;
                             CollectionReference usersRef = firebaseref.collection("users");
                            return  Form(
                                       key: _formKey,
                                       child: ListView(
                                        controller: _scrollController,
                                          children: <Widget>[
                                             Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                                 children: <Widget>[
                                                 Container(
                                                        margin: EdgeInsets.only(top: 20.0),
                                                        width: 100.0,
                                                        height: 100.0,
                                                        decoration: BoxDecoration(
                                                          color: third,
                                                          //image here
                                                          image: DecorationImage(
                                                         image: NetworkImage( '${snapshot.data['image']}' ),
                                                         fit: BoxFit.fill),
                                                          borderRadius:
                                                              BorderRadius.all(Radius.circular(75.0)),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                 
                                                   Padding(
                                                    padding: const EdgeInsets.all(10.0),
                                                    child: TextFormField(
                                                      initialValue: '${snapshot.data['name']}',
                                                      style: TextStyle(
                                                        fontSize: 18.0,
                                                      ),
                                                      onSaved: (input) => _court.name = input,
                                                      decoration: InputDecoration(
                                                         hintText: "إدخل اسم العائلة", 
                                                          hintStyle: TextStyle(
                                                            color: third,
                                                            fontSize: 18,
                                                          ),
                                                          contentPadding:
                                                              EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                                              border: OutlineInputBorder(
                                                              borderRadius: BorderRadius.circular(10.0)),
                                                      ),
                                                      validator: (value) {
                                                        if (value.isEmpty) {
                                                          _court.name = _court.name;
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ),
                                                   Padding(
                                                    padding: const EdgeInsets.all(10.0),
                                                    child: TextFormField(
                                                      initialValue: '${snapshot.data['username']}',
                                                      style: TextStyle(
                                                        fontSize: 18.0,
                                                      ),
                                                      onSaved: (input) => _court.username = input,
                                                      decoration: InputDecoration(
                                                         hintText: "إدخل اسم المستخدم", 
                                                          hintStyle: TextStyle(
                                                            color: third,
                                                            fontSize: 18,
                                                          ),
                                                          contentPadding:
                                                              EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                                              border: OutlineInputBorder(
                                                              borderRadius: BorderRadius.circular(10.0)),
                                                      ),
                                                      validator: (value) {
                                                        if (value.isEmpty) {
                                                          _court.username = _court.username;
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ),
                                                   Padding(
                                                    padding: const EdgeInsets.all(10.0),
                                                    child: TextFormField(
                                                      initialValue: '${snapshot.data['email']}',
                                                      style: TextStyle(
                                                        fontSize: 18.0,
                                                      ),
                                                      onSaved: (input) => _court.email = input,
                                                      decoration: InputDecoration(
                                                         hintText: "إدخل البريد الالكتروني", 
                                                        hintStyle: TextStyle(
                                                          color: third,
                                                          fontSize: 18,
                                                        ),
                                                        contentPadding:
                                                            EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                                            border: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(10.0)),
                                                        prefixIcon: Icon(
                                                          Icons.mail,
                                                          color: third,
                                                          size: 32.0,
                                                        ),
                                                      ),
                                                      validator: (value) {
                                                        if (value.isEmpty) {
                                                          _court.email = '${snapshot.data['email']}';
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ),
                                                   
                                              
                                                  Container(
                                                    padding: const EdgeInsets.all(10.0),
                                                    child: FloatingActionButton(
                                                      onPressed: () async{
                                                         firebaseUser = await _firebaseAuth.currentUser();
                                                        var userID = firebaseUser.uid;
                                                        if (_formKey.currentState.validate()) {
                                                          _formKey.currentState.save();
                                                          print(_court.email);
                                                           EmailAuthProvider.getCredential(email: 'email', password: 'password');
                                                           firebaseUser.updateEmail(_user.email);
                                                            usersRef.document(userID).updateData({
                                                             "name": _court.name,
                                                            "username": _court.username,
                                                            "email": _court.email,
                                                          }).then((data) {
                                                            print("تم");
                                                            // print(data);
                                                            Toast.show("تم التعديل بنجاح", context);
                                                             Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => profileUsers(
                                                                        currentUser: widget.currentUser,
                                                                      )));
                                                          }).catchError((err) {
                                                            print(err);
                                                            Toast.show("Error :" + err.toString(), context);
                                                          });
                                                        }
                                                         },
                                                      child: Text('حفظ'),
                                                      backgroundColor: third,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                          }
                  
                   

  }
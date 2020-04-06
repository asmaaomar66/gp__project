import 'package:gpproject/Auth/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gpproject/Pages/HelloApp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gpproject/Pages/AddTime.dart';

import 'ProfileUsers.dart';
import 'home.dart';
import 'lawyer_list.dart';


class drawerprofile extends StatefulWidget {
  drawerprofile({Key key  ,this.currentUser}) ;
  final FirebaseUser currentUser;

  @override
  drawerprofileState createState() => drawerprofileState();
}

class drawerprofileState extends State<drawerprofile>  {

  static Future<void> signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    FirebaseAuth.instance.signOut();
  }
Color prime = Color(0xff0e243b);
  Color second = Colors.white ;
  Color third =  Color(0xff0ccaee) ;

  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: StreamBuilder<DocumentSnapshot>(
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
          return CircularProgressIndicator();
        },
      ),
    );
  }

  Drawer checkRole(DocumentSnapshot snapshot) {
    if (snapshot.data == null) {
      return Drawer(
        child: Text('no data set in the userId document in firestore'),
      );
    }
    if (snapshot.data['role'] == '1') {
      return userPage(snapshot);
    }
    else if (snapshot.data['role'] == '2'){
      return lawyerPage(snapshot);
    } else{
      return courtPage(snapshot);
    } 
  }



  Drawer userPage(DocumentSnapshot snapshot) {
    return Drawer(
      child: SingleChildScrollView(
        child:
        Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              color: Theme.of(context).primaryColor,
              child: Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: third,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage('${snapshot.data['image']}'),
                            fit: BoxFit.fill),
                      ),
                    ),
                    Text('${snapshot.data['username']}',
                        style: TextStyle(fontSize: 22, color: Colors.white)),
                  ],
                ),
              ),
            ),
            ListTile(
              title: Text(
                'الصفحة الرئيسية',
                style: TextStyle(fontSize: 22),
              ),
              leading: Icon(
                Icons.home,
                size: 25,
                color: third,
              ),

              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MainPage(user: widget.currentUser,)));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                size: 25,
                color: third,
              ),
              title: Text(
                'الصفحة الشخصية',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => profileUsers(currentUser: widget.currentUser,)));
              },
            ),
            ListTile(
              leading: Icon(Icons.access_time, color: third,),
              title: Text(
                'مواعيد الحجوزات',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.settings , color: third,),
              title: Text(
                'الإعدادات',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.help,
                size: 25,
                color: third,
              ),
              title: Text(
                'أسال الان',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {
                 Navigator.push(context,MaterialPageRoute(builder: (context) =>  LawyerList(value: widget.currentUser)));
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app , color: third,),
              title: Text(
                'تسجيل الخروج',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {
                signOut();
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => HelloApp()));
              },
            ),
          ],
        ),
      ),
    );
    /*Center(
        child: Text('${snapshot.data['role']} ${snapshot.data['name']}'));*/
  }

  Drawer lawyerPage(DocumentSnapshot snapshot) {
    return Drawer(
      child: SingleChildScrollView(
        child:
        Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              color: Theme.of(context).primaryColor,
              child: Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: third,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage('${snapshot.data['image']}'),
                            fit: BoxFit.fill),
                      ),
                    ),
                    Text('${snapshot.data['username']}',
                        style: TextStyle(fontSize: 22, color: Colors.white)),
                  ],
                ),
              ),
            ),
            ListTile(
              title: Text(
                'الصفحة الرئيسية',
                style: TextStyle(fontSize: 22 ),
              ),
              leading: Icon(
                Icons.home,
                size: 25,
                color: third,
              ),

              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MainPage(user: widget.currentUser,)));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                size: 25,
                color: third,
              ),
              title: Text(
                'الصفحة الشخصية',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => profileUsers(currentUser: widget.currentUser,)));
              },
            ),
            ListTile(
              leading: Icon(Icons.hourglass_empty , color: third,),
              title: Text(
                'ادخال المواعيد المتاحه',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {
                 Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddTime(currentUser:widget.currentUser)));
              },
            ),
            ListTile(
              leading: Icon(Icons.access_time , color: third,),
              title: Text(
                'مواعيد الحجوزات',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.insert_drive_file , color: third,),
              title: Text(
                'رفع الملفات',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.settings , color: third,),
              title: Text(
                'الإعدادات',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {},
            ),

            ListTile(
              leading: Icon(Icons.exit_to_app , color: third,),
              title: Text(
                'تسجيل الخروج',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {
                signOut();
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => HelloApp()));
              },
            ),
          ],
        ),
      ),
    );
  }

  Drawer courtPage(DocumentSnapshot snapshot) {
    return Drawer(
      child: SingleChildScrollView(
        child:
        Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              color: Theme.of(context).primaryColor,
              child: Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: third,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage('${snapshot.data['image']}'),
                            fit: BoxFit.fill),
                      ),
                    ),
                    Text('${snapshot.data['username']}',
                        style: TextStyle(fontSize: 22, color: Colors.white)),
                  ],
                ),
              ),
            ),
            ListTile(
              title: Text(
                'الصفحة الرئيسية',
                style: TextStyle(fontSize: 22),
              ),
              leading: Icon(
                Icons.home,
                size: 25,
                color: third,
              ),

              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MainPage(user: widget.currentUser,)));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                size: 25,
                color: third,
              ),
              title: Text(
                'الصفحة الشخصية',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => profileUsers(currentUser: widget.currentUser,)));
              },
            ),
            ListTile(
              leading: Icon(Icons.archive , color: third,),
              title: Text(
                'الأرشيف',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {},
            ),
            /* ListTile(
              leading: Icon(Icons.fiber_new , color: third,),
              title: Text(
                'تحديث',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {},
            ),*/
            ListTile(
              leading: Icon(Icons.settings , color: third,),
              title: Text(
                'الإعدادات',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app , color: third,),
              title: Text(
                'تسجيل الخروج',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {
                signOut();
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => HelloApp()));
              },
            ),
          ],
        ),
      ),
    );
    /*Center(
        child: Text('${snapshot.data['role']} ${snapshot.data['name']}'));*/
  }

}


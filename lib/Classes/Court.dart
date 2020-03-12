import 'dart:async';
import 'package:gpproject/models/court.dart';

//import '../models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CourtClass {
  Court courtModel = new Court();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;

  Future<void> getCourtData() async {
    firebaseUser = await _firebaseAuth.currentUser();
    var courtID = firebaseUser.uid;
    DocumentSnapshot result = await Firestore.instance.collection('courts').document(courtID)
        .get().then((snapshot){
      setCourtData(snapshot);
      print(courtModel.username);
    });
    return result;
  }
  void setCourtData(x){
    print('in court class');
    courtModel.name = x['name'];
    courtModel.username = x['username'];
    courtModel.email = x['email'];
  }
  Court getCurrentCourt(){
    this.getCourtData();
    courtModel.email;
    return courtModel;
  }

  //update profile
  Future<void> updateProfile(Court court) async {
    print(court.email);
    firebaseUser = await _firebaseAuth.currentUser();
    var courtID = firebaseUser.uid;
    Firestore.instance.collection('courts').document(courtID).updateData({
      'username': court.username,
      'email': court.email,
      'name': court.name,

    });
  }

}
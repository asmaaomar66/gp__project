import 'dart:async';
import 'package:gpproject/models/lawyer.dart';

//import '../models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LawyerClass {
  Lawyer lawyerModel = new Lawyer();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;

  Future<void> getLawyerData() async {
    firebaseUser = await _firebaseAuth.currentUser();
    var lawyerID = firebaseUser.uid;
    DocumentSnapshot result = await Firestore.instance.collection('lawyers').document(lawyerID)
        .get().then((snapshot){
      setLawyerData(snapshot);
      print(lawyerModel.username);
    });
    return result;
  }
  void setLawyerData(x){
    print('in lawyer class');
    lawyerModel.fname = x['Firstname'];
    lawyerModel.lname = x['Lastname'];
    lawyerModel.username = x['username'];
    lawyerModel.phone = x['phone'];
    lawyerModel.email = x['email'];
    lawyerModel.paddress = x['gender'];
  }
  Lawyer getCurrentLawyer(){
    this.getLawyerData();
    lawyerModel.phone;
    return lawyerModel;
  }

  //update profile
  Future<void> updateProfile(Lawyer lawyer) async {
    print(lawyer.email);
    firebaseUser = await _firebaseAuth.currentUser();
    var lawyerID = firebaseUser.uid;
    Firestore.instance.collection('lawyers').document(lawyerID).updateData({
      'username': lawyer.username,
      'email': lawyer.email,
      'phone': lawyer.phone,
      'gender': lawyer.paddress,
      'lname': lawyer.officenumber,
      'officeaddress' : lawyer.officeaddress ,

    });
  }

}
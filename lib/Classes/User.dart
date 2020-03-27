import 'dart:async';
import '../models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserClass {
  User userModel = new User();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;

  Future<void> getUserData() async {
    firebaseUser = await _firebaseAuth.currentUser();
    var userID = firebaseUser.uid;
    DocumentSnapshot result = await Firestore.instance.collection('users').document(userID)
        .get().then((snapshot){
      setUserData(snapshot);
      print(userModel.username);
    });
    return result;
  }
  void setUserData(x){
    print('in user class');
    userModel.fname = x['Fname'];
    userModel.lname = x['Lname'];
    userModel.username = x['username'];
    userModel.phone = x['phone'];
    userModel.email = x['email'];
    userModel.gender = x['gender'];
    userModel.image = x['image'];

  }
  User getCurrentUser(){
    this.getUserData();
    userModel.phone;
    return userModel;
  }
Future<String>getcurrentUID() async{
  return (await _firebaseAuth.currentUser()).uid ;
}
  //update profile
  Future<void> updateProfile(User user) async {
    print(user.email);
    firebaseUser = await _firebaseAuth.currentUser();
    var userID = firebaseUser.uid;
    Firestore.instance.collection('users').document(userID).updateData({
      'username': user.username,
      'email': user.email,
      'phone': user.phone,
      'gender': user.gender,
      'lname': user.lname,

    });
  }

}
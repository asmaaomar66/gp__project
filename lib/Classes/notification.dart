import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gpproject/models/user.dart';
import 'package:gpproject/Classes/User.dart';
import 'package:intl/intl.dart';

class NotificationClass{
String format;
 String currentTime(){
    DateTime now = DateTime.now();
    format = DateFormat('kk:mm:ss EEE d MMM').format(now);
   return format;
   }

  

}
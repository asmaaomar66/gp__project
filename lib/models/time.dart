import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

Time timeFromJson(String str) {
  final jsonData = json.decode(str);
  return Time.fromJson(jsonData);
}

String timeToJson(Time data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class Time {
  String timeId;
  int lawyerId;
  String timeNum;
  DateTime day;
  DateTime time;
  String amORpm ;
  
  

  Time({
    this.timeId,
    this.lawyerId,
    this.timeNum,
    this.day,
    this.time,
    this.amORpm,
  });
  Map<String, dynamic> toJson() => {
    "timeid": timeId,
    "lawyerId": lawyerId,
    "timeNum": timeNum,
    "day": day,
    "time": time,
    "amORpm": amORpm,
  };
  factory Time.fromJson(Map<String, dynamic> json) => new Time(
    timeId: json["timeId"],
    lawyerId: json["lawyerId"],
    timeNum: json["timeNum"],
    day: json["day"],
    time: json["time"],
    amORpm: json["amORpm"],
    
  );
  factory Time.fromDocument(DocumentSnapshot doc) {
    return Time.fromJson(doc.data);
  }
}
class TimeList{
  List<Time> timeList;

  TimeList({this.timeList});
}
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
  String day;
  DateTime date;
  String time;
  bool state;
  Map<String ,bool > dayTimes;
 
  
  

  Time({
    this.timeId,
    this.lawyerId,
    this.day,
    this.date,
    this.time,
    this.dayTimes,
    this.state
    
  });
  Map<String, dynamic> toJson() => {
    "timeid": timeId,
    "lawyerId": lawyerId,
     "date": date,
    "day": day,
    "time": time,
    "state":state
    
  };
  factory Time.fromJson(Map<String, dynamic> json) => new Time(
    timeId: json["timeId"],
    lawyerId: json["lawyerId"],
    date:json["date"],
    day: json["day"],
    time: json["time"],
   state:json["state"],
    
  );
  factory Time.fromDocument(DocumentSnapshot doc) {
    return Time.fromJson(doc.data);
  }
}
class TimeList{
  List<Time> timeList;

  TimeList({this.timeList});
}
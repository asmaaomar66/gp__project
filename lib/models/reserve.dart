import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

Reserve timeFromJson(String str) {
  final jsonData = json.decode(str);
  return Reserve.fromJson(jsonData);
}

String timeToJson(Reserve data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class Reserve {
  String reserveId;
  String lawyerId;
  String userId;
  String userName;
  String cases;
  String timeId;
  DateTime date;
  String pepar;
 
 
 
  
  

  Reserve({
    this.reserveId,
    this.lawyerId,
    this.userId,
    this.cases,
    this.timeId,
    this.userName,
    this.date,
    this.pepar
 
  });
  Map<String, dynamic> toJson() => {
    "reserveId": reserveId,
    "lawyerId": lawyerId,
     "userId": userId,
      "userName":userName,
    "cases": cases,
    "timeId": timeId,
    "date":date,
    "paper":pepar
  };
  factory Reserve.fromJson(Map<String, dynamic> json) => new Reserve(
    reserveId: json["reserveId"],
    lawyerId: json["lawyerId"],
    userId:json["userId"],
    userName:json["userName"],
    cases: json["cases"],
    timeId: json["timeId"],
   date:json["date"],
    pepar: json["paper"]
  );
  factory Reserve.fromDocument(DocumentSnapshot doc) {
    return Reserve.fromJson(doc.data);
  }
}
class ReserveList{
  List<Reserve> reserveList;

   ReserveList({this.reserveList});
}
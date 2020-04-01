import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

cases casesFromJson(String str) {
  final jsonData = json.decode(str);
  return cases.fromJson(jsonData);
}

String casesToJson(cases data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class cases {
  String caseId;
  int courtId;
  String caseType;
  String caseState;
  String victimName;
  String offenderName;
  String crimeName;
  String caseDate;
  String caseNumber;
  cases({
    this.caseId,
    this.courtId,
    this.caseType,
    this.caseState,
    this.victimName,
    this.offenderName,
    this.crimeName,
    this.caseDate,
    this.caseNumber

  });
  Map<String, dynamic> toJson() => {
    "caseId": caseId,
    "courtId": courtId,
    "caseType": caseType,
    "caseState": caseState,
    "victimName": victimName,
    "offenderName": offenderName,
    "crimeName": crimeName,
    "caseDate": caseDate,
    "caseNumber": caseNumber,

  };
  factory cases.fromJson(Map<String, dynamic> json) => new cases(
    caseId: json["caseId"],
    courtId: json["courtId"],
    caseType: json["caseType"],
    caseState: json["caseState"],
    victimName: json["victimName"],
    offenderName: json["offenderName"],
    crimeName: json["crimeName"],
    caseDate: json["caseDate"],
    caseNumber: json["caseNumber"]
    
  );
  factory cases.fromDocument(DocumentSnapshot doc) {
    return cases.fromJson(doc.data);
  }
}
class CaseList{
  List<cases> caseList;

  CaseList({this.caseList});
}
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

archivedCases archivedCasesFromJson(String str) {
  final jsonData = json.decode(str);
  return archivedCases.fromJson(jsonData);
}

String archivedCasesToJson(archivedCases data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class archivedCases {
  String caseId;
  int courtId;
  String caseType;
  String caseState;
  String victimName;
  String offenderName;
  String crimeName;
  String caseDate;
  String caseNumber;
  archivedCases({
    this.caseId,
    this.courtId,
    this.caseType,
    this.caseState,
    this.victimName,
    this.offenderName,
    this.crimeName,
    this.caseDate,
    this.caseNumber, currentCourt

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
  factory archivedCases.fromJson(Map<String, dynamic> json) => new archivedCases(
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
  factory archivedCases.fromDocument(DocumentSnapshot doc) {
    return archivedCases.fromJson(doc.data);
  }
}
class ArchivedCasesList{
  List<archivedCases> archivedCasesList;

  ArchivedCasesList({this.archivedCasesList});
}
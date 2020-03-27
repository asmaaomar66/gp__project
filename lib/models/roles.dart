import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

Role RoleFromJson(String str) {
  final jsonData = json.decode(str);
  return Role.fromJson(jsonData);
}

String roleToJson(Role data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class Role {
  String rId;
  String rolename ;
  String subjectname;
  String bandname;

  Role({
    this.rId,
    this.rolename,
    this.subjectname,
    this.bandname,
  });
  Map<String, dynamic> toJson() => {
    "id": rId,
    "Role-name": rolename,
    "Subject-name": subjectname,
    "Band-name": bandname,
  };
  factory Role.fromJson(Map<String, dynamic> json) => new Role(
    rId: json["id"],
    rolename: json["Role-name"],
    subjectname: json["Subject-name"],
    bandname: json["Band-name"],
  );
  factory Role.fromDocument(DocumentSnapshot doc) {
    return Role.fromJson(doc.data);
  }
}
class RoleList{
  List<Role> roleList;

  RoleList({this.roleList});
}
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
  String rolenumber ;
  String subjectname; 
  String bandname;
  String role;

  Role({
    this.rId,
    this.rolename,
    this.rolenumber,
    this.subjectname,
    this.bandname,
    this.role,
  });
  Map<String, dynamic> toJson() => {
    "id": rId,
    "Rolename": rolename,
    "Rolenumber":rolenumber,
    "Subjectname": subjectname,
    "Bandname": bandname,
     "role": 'rule',
  };
  factory Role.fromJson(Map<String, dynamic> json) => new Role(
    rId: json["id"],
    rolename: json["Rolename"],
    rolenumber: json["Rolenumber"],
    subjectname: json["Subjectname"],
    bandname: json["Bandname"],
    role: json["rule"],
  );
  factory Role.fromDocument(DocumentSnapshot doc) {
    return Role.fromJson(doc.data);
  }
}
class RoleList{
  List<Role> roleList;

  RoleList({this.roleList});
}
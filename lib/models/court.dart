import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

Court CourtFromJson(String str) {
  final jsonData = json.decode(str);
  return Court.fromJson(jsonData);
}

String courtToJson(Court data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class Court {
  String cId;
  String name ;
  String username;
  String email;
  String password;
  String role;
 // File photo;
  String image;

  Court({
    this.cId,
    this.name,
    this.username,
    this.email,
    this.password,
    this.role,
  //  this.photo,
    this.image
  });
  Map<String, dynamic> toJson() => {
    "id": cId,
    "name": name,
    "username": username,
    "email": email,
    "password": password,
   // "photo":photo,
    "image": image,
    "role": '3',
  };
  factory Court.fromJson(Map<String, dynamic> json) => new Court(
    cId: json["id"],
    name: json["name"],
    username: json["username"],
    email: json["email"],
    password: json["password"],
  //  photo: json["photo"],
    image: json["image"],
    role: json["3"],
  );
  factory Court.fromDocument(DocumentSnapshot doc) {
    return Court.fromJson(doc.data);
  }
}
class CourtList{
  List<Court> courtList;

  CourtList({this.courtList});
}
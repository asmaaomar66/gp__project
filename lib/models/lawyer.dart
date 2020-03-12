import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

Lawyer LawyerFromJson(String str) {
  final jsonData = json.decode(str);
  return Lawyer.fromJson(jsonData);
}

String lawyerToJson(Lawyer data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class Lawyer {
  String lId;
  String fname;
  String lname ;
  String username;
  String email;
  String password;
  String phone;
  String paddress;
  String officeaddress;
  String officenumber;
  String category;
  String role;
//  File photo;
  String image;

  Lawyer({
    this.lId,
    this.fname,
    this.lname,
    this.username,
    this.email,
    this.password,
    this.phone,
    this.paddress,
    this.officeaddress,
    this.officenumber,
    this.category,
    this.role,
  //  this.photo,
    this.image
  });
  Map<String, dynamic> toJson() => {
    "id": lId,
    "fname": fname,
    "lname": lname,
    "username": username,
    "email": email,
    "password": password,
    "phone": phone,
    "personaladdress.": paddress,
    "officeaddress": officeaddress,
    "officenumber": officenumber,
    "category": category,
   // "photo":photo,
    "image": image,
    "role": '2',
  };
  factory Lawyer.fromJson(Map<String, dynamic> json) => new Lawyer(
    lId: json["id"],
    fname: json["fname"],
    lname: json["lname"],
    username: json["username"],
    email: json["email"],
    password: json["password"],
    phone: json["phone"],
    paddress: json["paddress."],
    officeaddress: json["officeaddress"],
    officenumber: json["officenumber"],
    category: json["category"],
   // photo: json["photo"],
    image: json["image"],
    role: json["2"],
  );
  factory Lawyer.fromDocument(DocumentSnapshot doc) {
    return Lawyer.fromJson(doc.data);
  }
}
class LawyerList{
  List<Lawyer> lawyerList;

  LawyerList({this.lawyerList});
}
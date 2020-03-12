import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

User userFromJson(String str) {
  final jsonData = json.decode(str);
  return User.fromJson(jsonData);
}

String userToJson(User data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class User {
  String uId;
  String fname;
  String lname ;
  String username;
  String email;
  String password;
  String phone;
  String image;
  int gender;
  String role;
 // File photo;
//  String lawyerId ;
  User(
      {this.uId,
        this.fname,
        this.lname,
        this.username,
        this.email,
        this.password,
        this.phone,
        this.image ,
        this.gender,
        this.role,
      //  this.photo,
       // this.lawyerId,
        });

  Map<String, dynamic> toJson() => {
    "id": uId,
    "fname": fname,
    "lname": lname,
    "username": username,
    "email": email,
    "password": password,
    "phone": phone,
    "image": image,
    "gender": gender,
  //  "photo": photo,
    "image": image,
   // "lawyerId": lawyerId,
    "role": '1',
  };
  factory User.fromJson(Map<String, dynamic> json) => new User(
    uId: json["id"],
    fname: json["fname"],
    lname: json["lname"],
    username: json["username"],
    email: json["email"],
    password: json["password"],
    phone: json["phone"],
    image: json["image"],
    gender: json["gender"],
  //  photo: json["photo"],
   // lawyerId: json["lawyerId"],
    role: json["1"],
  );
  factory User.fromDocument(DocumentSnapshot doc) {
    return User.fromJson(doc.data);
  }
}
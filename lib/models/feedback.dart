import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

feedback feedbackFromJson(String str) {
  final jsonData = json.decode(str);
  return feedback.fromJson(jsonData);
}

String feedbackToJson(feedback data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class feedback {
  String feedbackId;
  String lawyerId;
  String userId;
  String feedbackContent;

  feedback({
    this.feedbackId,
    this.lawyerId,
    this.userId,
    this.feedbackContent,
   
  });
  Map<String, dynamic> toJson() => {
    "feedbackId": feedbackId,
    "lawyerId": lawyerId,
    "userId": userId,
    "feedbackContent": feedbackContent,


  };
  factory feedback.fromJson(Map<String, dynamic> json) => new feedback(
    feedbackId: json["feedbackId"],
    lawyerId: json["lawyerId"],
    userId: json["userId"],
    feedbackContent: json["feedbackContent"],
    
  );
  factory feedback.fromDocument(DocumentSnapshot doc) {
    return feedback.fromJson(doc.data);
  }
}
class FeedbackList{
  List<feedback> feedbackList;

  FeedbackList({this.feedbackList});
}
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:gpproject/models/roles.dart';

class SearchService {
  searchByName(String searchField) {
    return Firestore.instance
        .collection('lawyer')
        .where('searchkey',
        isEqualTo: searchField.substring(0, 1).toUpperCase())
        .getDocuments();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';


class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;

  Observable<FirebaseUser> user;
  Observable<Map<String, dynamic>> profile;
  PublishSubject loading = PublishSubject();

  AuthService(){
    user = Observable(_auth.onAuthStateChanged);
    profile = user.switchMap((FirebaseUser u){
      if (u != null){
        return _db.collection('users').document(u.uid).snapshots().map((snap)=> snap.data);
      }else {
        return Observable.just({});
      }
    });
  }


  void updateUserData (FirebaseUser user) async{
    DocumentReference ref = _db.collection('users').document(user.uid);

    return ref.setData({
      'uid': user.uid,
      'email' : user.email,
      'photoURL' : user.photoUrl,
      'displayName' : user.displayName,
      'lastSeen' : DateTime.now(),
    }, merge: true
    );

  }
}

final AuthService authService = AuthService();

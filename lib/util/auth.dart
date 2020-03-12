import 'dart:async';
//import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';
import '../models/lawyer.dart';
import '../models/court.dart';
import '../models/settings.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum authProblems { UserNotFound, PasswordNotValid, NetworkError, UnknownError }

class Auth {
  static Future<String> signUp(String email, String password) async {
    AuthResult user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return user.user.uid;
  }

  static void addUserSettingsDB(User user) async {
    checkUserExist(user.uId).then((value) {
      if (!value) {
        print("user ${user.username} ${user.email} added");
        Firestore.instance.document("users/${user.uId}").setData(user.toJson());
        _addSettings(new Settings(
          settingsId: user.uId,
        ));
      } else {
        print("user ${user.username} ${user.email} exists");
      }
    });
  }

  static Future<bool> checkUserExist(String userId) async {
    bool exists = false;
    try {
      await Firestore.instance.document("users/$userId").get().then((doc) {
        if (doc.exists)
          exists = true;
        else
          exists = false;
      });
      return exists;
    } catch (e) {
      return false;
    }
  }

  static void _addSettings(Settings settings) async {
    Firestore.instance
        .document("settings/${settings.settingsId}")
        .setData(settings.toJson());
  }

  static Future<String> signIn(String email, String password) async {
    FirebaseUser user = (await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email, password: password)) as FirebaseUser;
    return user.uid;
  }

  static Future<User> getUserFirestore(String userId) async {
    if (userId != null) {
      return Firestore.instance
          .collection('users')
          .document(userId)
          .get()
          .then((documentSnapshot) => User.fromDocument(documentSnapshot));
    } else {
      print('firestore userId can not be null');
      return null;
    }
  }

  static Future<Settings> getSettingsFirestore(String settingsId) async {
    if (settingsId != null) {
      return Firestore.instance
          .collection('settings')
          .document(settingsId)
          .get()
          .then((documentSnapshot) => Settings.fromDocument(documentSnapshot));
    } else {
      print('no firestore settings available');
      return null;
    }
  }

  static Future<String> storeUserLocal(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String storeUser = userToJson(user);
    await prefs.setString('user', storeUser);
    return user.uId;
  }

  static Future<String> storeSettingsLocal(Settings settings) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String storeSettings = settingsToJson(settings);
    await prefs.setString('settings', storeSettings);
    return settings.settingsId;
  }

  static Future<FirebaseUser> getCurrentFirebaseUser() async {
    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    return currentUser;
  }

  static Future<User> getUserLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('user') != null) {
      User user = userFromJson(prefs.getString('user'));
      //print('USER: $user');
      return user;
    } else {
      return null;
    }
  }

  static Future<Settings> getSettingsLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('settings') != null) {
      Settings settings = settingsFromJson(prefs.getString('settings'));
      //print('SETTINGS: $settings');
      return settings;
    } else {
      return null;
    }
  }

  static Future<void> signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    FirebaseAuth.instance.signOut();
  }

  static Future<void> forgotPasswordEmail(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  static String getExceptionText(Exception e) {
    if (e is PlatformException) {
      switch (e.message) {
        case 'There is no user record corresponding to this identifier. The user may have been deleted.':
          return 'User with this email address not found.';
          break;
        case 'The password is invalid or the user does not have a password.':
          return 'Invalid password.';
          break;
        case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
          return 'No internet connection.';
          break;
        case 'The email address is already in use by another account.':
          return 'This email address already has an account.';
          break;
        default:
          return 'Unknown error occured.';
      }
    } else {
      return 'Unknown error occured.';
    }
  }

  ///lawyer
  static Future<String> signUp2(String email, String password) async {
    AuthResult lawyer = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return lawyer.user.uid;
  }

  static void addUserSettingsDB2(Lawyer lawyer) async {
    checkUserExist(lawyer.lId).then((value) {
      if (!value) {
        print("user ${lawyer.username} ${lawyer.email} added");
        Firestore.instance
            .document("users/${lawyer.lId}")
            .setData(lawyer.toJson());
        _addSettings(new Settings(
          settingsId: lawyer.lId,
        ));
      } else {
        print("user ${lawyer.username} ${lawyer.email} exists");
      }
    });
  }

  static Future<bool> checkUserExist2(String lawyerId) async {
    bool exists = false;
    try {
      await Firestore.instance.document("users/$lawyerId").get().then((doc) {
        if (doc.exists)
          exists = true;
        else
          exists = false;
      });
      return exists;
    } catch (e) {
      return false;
    }
  }

  static void _addSettings2(Settings settings) async {
    Firestore.instance
        .document("settings/${settings.settingsId}")
        .setData(settings.toJson());
  }

  static Future<String> signIn2(String email, String password) async {
    FirebaseUser lawyer = (await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password))
    as FirebaseUser;
    return lawyer.uid;
  }

  static Future<Lawyer> getUserFirestore2(String lawyerId) async {
    if (lawyerId != null) {
      return Firestore.instance
          .collection('lawyers')
          .document(lawyerId)
          .get()
          .then((documentSnapshot) => Lawyer.fromDocument(documentSnapshot));
    } else {
      print('firestore userId can not be null');
      return null;
    }
  }

  static Future<Settings> getSettingsFirestore2(String settingsId) async {
    if (settingsId != null) {
      return Firestore.instance
          .collection('settings')
          .document(settingsId)
          .get()
          .then((documentSnapshot) => Settings.fromDocument(documentSnapshot));
    } else {
      print('no firestore settings available');
      return null;
    }
  }

  static Future<String> storeUserLocal2(Lawyer lawyer) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String storeUser = lawyerToJson(lawyer);
    await prefs.setString('lawyer', storeUser);
    return lawyer.lId;
  }

  static Future<String> storeSettingsLocal2(Settings settings) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String storeSettings = settingsToJson(settings);
    await prefs.setString('settings', storeSettings);
    return settings.settingsId;
  }

  static Future<FirebaseUser> getCurrentFirebaseUser2() async {
    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    return currentUser;
  }

  static Future<Lawyer> getUserLocal2() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('lawyer') != null) {
      Lawyer lawyer = LawyerFromJson(prefs.getString('lawyer'));
      //print('USER: $user');
      return lawyer;
    } else {
      return null;
    }
  }

  static Future<Settings> getSettingsLocal2() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('settings') != null) {
      Settings settings = settingsFromJson(prefs.getString('settings'));
      //print('SETTINGS: $settings');
      return settings;
    } else {
      return null;
    }
  }

  static Future<void> signOut2() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    FirebaseAuth.instance.signOut();
  }

  static Future<void> forgotPasswordEmail2(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  static String getExceptionText2(Exception e) {
    if (e is PlatformException) {
      switch (e.message) {
        case 'There is no user record corresponding to this identifier. The user may have been deleted.':
          return 'User with this email address not found.';
          break;
        case 'The password is invalid or the user does not have a password.':
          return 'Invalid password.';
          break;
        case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
          return 'No internet connection.';
          break;
        case 'The email address is already in use by another account.':
          return 'This email address already has an account.';
          break;
        default:
          return 'Unknown error occured.';
      }
    } else {
      return 'Unknown error occured.';
    }
  }

  ///court
  static Future<String> signUp3(String email, String password) async {
    AuthResult court = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return court.user.uid;
  }

  static void addUserSettingsDB3(Court court) async {
    checkUserExist(court.cId).then((value) {
      if (!value) {
        print("user ${court.username} ${court.email} added");
        Firestore.instance.document("users/${court.cId}").setData(court.toJson());
        _addSettings(new Settings(
          settingsId: court.cId,
        ));
      } else {
        print("user ${court.username} ${court.email} exists");
      }
    });
  }

  static Future<bool> checkUserExist3(String courtId) async {
    bool exists = false;
    try {
      await Firestore.instance.document("users/$courtId").get().then((doc) {
        if (doc.exists)
          exists = true;
        else
          exists = false;
      });
      return exists;
    } catch (e) {
      return false;
    }
  }

  static void _addSettings3(Settings settings) async {
    Firestore.instance
        .document("settings/${settings.settingsId}")
        .setData(settings.toJson());
  }

  static Future<String> signIn3(String email, String password) async {
    FirebaseUser court = (await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email, password: password)) as FirebaseUser;
    return court.uid;
  }

  static Future<Court> getUserFirestore3(String courtId) async {
    if (courtId != null) {
      return Firestore.instance
          .collection('courts')
          .document(courtId)
          .get()
          .then((documentSnapshot) => Court.fromDocument(documentSnapshot));
    } else {
      print('firestore userId can not be null');
      return null;
    }
  }

  static Future<Settings> getSettingsFirestore3(String settingsId) async {
    if (settingsId != null) {
      return Firestore.instance
          .collection('settings')
          .document(settingsId)
          .get()
          .then((documentSnapshot) => Settings.fromDocument(documentSnapshot));
    } else {
      print('no firestore settings available');
      return null;
    }
  }

  static Future<String> storeUserLocal3(Court court) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String storeUser = courtToJson(court);
    await prefs.setString('court', storeUser);
    return court.cId;
  }

  static Future<String> storeSettingsLocal3(Settings settings) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String storeSettings = settingsToJson(settings);
    await prefs.setString('settings', storeSettings);
    return settings.settingsId;
  }

  static Future<FirebaseUser> getCurrentFirebaseUser3() async {
    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    return currentUser;
  }

  static Future<Court> getUserLocal3() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('court') != null) {
      Court court = CourtFromJson(prefs.getString('court'));
      //print('USER: $user');
      return court;
    } else {
      return null;
    }
  }

  static Future<Settings> getSettingsLocal3() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('settings') != null) {
      Settings settings = settingsFromJson(prefs.getString('settings'));
      //print('SETTINGS: $settings');
      return settings;
    } else {
      return null;
    }
  }

  static Future<void> signOut3() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    FirebaseAuth.instance.signOut();
  }

  static Future<void> forgotPasswordEmail3(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  static String getExceptionText3(Exception e) {
    if (e is PlatformException) {
      switch (e.message) {
        case 'There is no user record corresponding to this identifier. The user may have been deleted.':
          return 'User with this email address not found.';
          break;
        case 'The password is invalid or the user does not have a password.':
          return 'Invalid password.';
          break;
        case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
          return 'No internet connection.';
          break;
        case 'The email address is already in use by another account.':
          return 'This email address already has an account.';
          break;
        default:
          return 'Unknown error occured.';
      }
    } else {
      return 'Unknown error occured.';
    }
  }

}
import 'package:gpproject/models/user.dart';
import 'package:gpproject/util/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'login.dart';
import 'package:image_picker/image_picker.dart';

class SignUpUser extends StatefulWidget {
  final User user;
  SignUpUser({Key key, this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return new _SignUpUser();
  }
}

class _SignUpUser extends State<SignUpUser> {
  bool isloading = false;
 ScrollController _scrollController = new ScrollController();
  File _image1, _image2, _image3, _image4;
  String imageurl;
  // Uri
  String downloadUrl,
      _fname,
      _lname,
      _username,
      _password,
      _email,
      _phone,
      _photo;
  int _gender = -1, correctScore = 0;
  // final userrefrence = Firestore.instance.collection('User');
  TextEditingController _ChildUserNameController = TextEditingController();
  TextEditingController _ChildEmailController = TextEditingController();
  TextEditingController _ChildFirstnameController = TextEditingController();
  TextEditingController _ChildFamilynameController = TextEditingController();
  TextEditingController _ChildPhonenumberController = TextEditingController();
  TextEditingController _ChildPassWordController = TextEditingController();
  bool _autoValidate = false;
  bool _loadingVisible = false;
  final _formkey = GlobalKey<FormState>();
  Color prime = Color(0xff0e243b);
  Color second = Colors.white ;
  Color third =  Color(0xff0ccaee) ;
  
  Future getImage(File requierdImage) async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      requierdImage = image;
    });
  }

  Future getImageFromCamera(File requierdImage) async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      requierdImage = image;
    });
  }

  Future<String> UploadImage(File image) async {
    String name = Random().nextInt(1000).toString() + '_child';
    final StorageReference storageReference =
        FirebaseStorage().ref().child(name);
    final StorageUploadTask UploadTask = storageReference.putFile(image);
    StorageTaskSnapshot respons = await UploadTask.onComplete;
    String URL = await respons.ref.getDownloadURL();

    return URL;
  }

  Widget _displayImagesGridsCamera() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: IconButton(
                  icon: Icon(
                    Icons.camera_alt,
                    color: third,
                  ),
                  onPressed: () async {
                    var image =
                        await ImagePicker.pickImage(source: ImageSource.camera);

                    setState(() {
                      _image4 = image;
                    });
                  }),
            )
          ],
        )
      ],
    );
  }

  Widget _displayImagesGridsfile() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: IconButton(
                  icon: Icon(
                    Icons.photo_filter,
                    color: third,
                  ),
                  onPressed: () async {
                    var image = await ImagePicker.pickImage(
                        source: ImageSource.gallery);

                    setState(() {
                      _image1 = image;
                    });
                  }),
            )
          ],
        )
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _ChildUserNameController.dispose();
    _ChildEmailController.dispose();
    _ChildFirstnameController.dispose();
    _ChildFamilynameController.dispose();
    _ChildPhonenumberController.dispose();
    _ChildPassWordController.dispose();
  }

  String dropval;
  void dropchange(String val) {
    setState(() {
      dropval = val;
    });
  }

  void _handleRadioValueChange1(int value) {
    setState(() {
      _gender = value;

      switch (_gender) {
        case 0:
          correctScore++;
          break;
        case 1:
          correctScore++;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
    onWillPop: () async => false,
    child: new Scaffold(
      body: ListView(
        children: <Widget>[
          new Container(
            color: prime,
            child: new Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      left: 15, top: 10, right: 0, bottom: 20.0),
                ),
                new Card(
                  margin: EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 30, bottom: 0),
                  child: new Form(
                    key: _formkey,
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      //controller: _scrollController,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 30, bottom: 20),
                          child: Text(
                            'الملف الشخصي',
                            style: TextStyle(
                                fontSize: 25.0,
                                color: third,
                                fontWeight: FontWeight.w900),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(
                              left: 15, top: 10, right: 0, bottom: 20.0),
                          child: TextFormField(
                            //cursorColor: Colors.white70 ,
                            controller: _ChildFirstnameController,
                            keyboardType: TextInputType.text,
                            autofocus: false,
                            textDirection: TextDirection.rtl,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                color: third,
                                fontSize: 18,
                              ),
                              alignLabelWithHint: true,
                              hintText: " ادخل الاسم الأول",
                              icon: new RawMaterialButton(
                                onPressed: () {},
                                child: new Icon(
                                  Icons.perm_identity,
                                  color: second,
                                  size: 23,
                                ),
                                shape: new CircleBorder(),
                                fillColor: third,
                              ),
                              contentPadding:
                                  EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'من فضلك ادخل الاسم';
                              }
                              return null;
                            },
                           // validator: validateName,
                            onSaved: (input) => _fname = input,
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(
                              left: 15, top: 10, right: 0, bottom: 20.0),
                          child: TextFormField(
                            controller: _ChildFamilynameController,
                            keyboardType: TextInputType.text,
                            autofocus: false,
                            textDirection: TextDirection.rtl,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                color: third,
                                fontSize: 18,
                              ),
                              alignLabelWithHint: true,
                              hintText: " ادخل اسم العائلة",
                              icon: new RawMaterialButton(
                                onPressed: () {},
                                child: new Icon(
                                  Icons.group,
                                  color: second,
                                  size: 23,
                                ),
                                shape: new CircleBorder(),
                                fillColor: third,
                              ),
                              contentPadding:
                                  EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                            ),
                           validator: (value) {
                              if (value.isEmpty) {
                                return 'من فضلك ادخل اسم العائلة ';
                              }
                              return null;
                            },
                           // validator: validateName,
                            onSaved: (input) => _lname = input,
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(
                              left: 15, top: 10, right: 0, bottom: 20.0),
                          child: TextFormField(
                            controller: _ChildUserNameController,
                            keyboardType: TextInputType.text,
                            autofocus: false,
                            textDirection: TextDirection.rtl,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                color: third,
                                fontSize: 18,
                              ),
                              alignLabelWithHint: true,
                              hintText: " ادخل اسم المستخدم",
                              icon: new RawMaterialButton(
                                onPressed: () {},
                                child: new Icon(
                                  Icons.perm_identity,
                                  color: second,
                                  size: 23,
                                ),
                                shape: new CircleBorder(),
                                fillColor: third,
                              ),
                              contentPadding:
                                  EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                            ),
                            validator: validateName,
                            onSaved: (input) => _username = input,
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(
                              left: 15, top: 10, right: 0, bottom: 20.0),
                          child: TextFormField(
                            controller: _ChildEmailController,
                            keyboardType: TextInputType.emailAddress,
                            autofocus: false,
                            textDirection: TextDirection.rtl,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                color: third,
                                fontSize: 18,
                              ),
                              alignLabelWithHint: true,
                              hintText: " ادخل البريد الإلكتروني",
                              icon: new RawMaterialButton(
                                onPressed: () {},
                                child: new Icon(
                                  Icons.email,
                                  color: second,
                                  size: 23,
                                ),
                                shape: new CircleBorder(),
                                fillColor: third,
                              ),
                              contentPadding:
                                  EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                            ),
                            validator: validateEmail,
                            onSaved: (input) => _email = input,
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(
                              left: 15, top: 10, right: 0, bottom: 20.0),
                          child: TextFormField(
                            controller: _ChildPassWordController,
                            keyboardType: TextInputType.visiblePassword,
                            autofocus: false,
                            obscureText: true,
                            textDirection: TextDirection.rtl,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                color: third,
                                fontSize: 18,
                              ),
                              alignLabelWithHint: true,
                              hintText: " ادخل كلمة السر",
                              icon: new RawMaterialButton(
                                onPressed: () {},
                                child: new Icon(
                                  Icons.lock,
                                  color: second,
                                  size: 23,
                                ),
                                shape: new CircleBorder(),
                                fillColor: third,
                              ),
                              contentPadding:
                                  EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                            ),
                            validator: (input) {
                              if (input.isEmpty) {
                                return 'من فضلك ادخل كلمة المرور';
                              }
                              if (input.length < 8) {
                                return 'كلمة المرور يجب الا تقل عن ثماني ارقام او حروف';
                              }
                            },
                            onSaved: (input) => _password = input,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 15, top: 10, right: 0, bottom: 20.0),
                          child: TextFormField(
                            controller: _ChildPhonenumberController,
                            keyboardType: TextInputType.phone,
                            autofocus: false,
                            textDirection: TextDirection.rtl,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                color: third,
                                fontSize: 18,
                              ),
                              alignLabelWithHint: true,
                              hintText: " ادخل رقم الهاتف",
                              icon: new RawMaterialButton(
                                onPressed: () {},
                                child: new Icon(
                                  Icons.phone_android,
                                  color: second,
                                  size: 23,
                                ),
                                shape: new CircleBorder(),
                                fillColor: third,
                              ),
                              contentPadding:
                                  EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                            ),
                           /* validator: (value) {
                              if (value.isEmpty) {
                                return ' من فضلك ادخل رقم الهاتف الجوال';
                              }
                              if (value.length < 11) {
                                return 'يجب الا يقل رقم الهاتف عن 11 رقم';
                              }
                              return null;
                            },*/
                            validator: validateMobile,
                            onSaved: (input) => _phone = input,
                          ),
                        ),
//                          Padding(
//                            padding: EdgeInsets.only(
//                                left: 30, right: 90, top: 20, bottom: 10),
//                            child: DropdownButton<String>(
//                              hint: Text('النوع',
//                                  style: TextStyle(
//                                      fontWeight: FontWeight.bold,
//                                      color: Colors.black45,
//                                      fontSize: 22)), // Not necessary for Option 1
//                              value: dropval,
//                              onChanged: dropchange,
//                              isExpanded: true,
//                              icon: Icon(Icons.accessibility_new),
//                              iconSize: 24,
//                              elevation: 1,
//                              style: TextStyle(color: Colors.teal),
//                              underline: Container(
//                                height: 2,
//                                color: Colors.teal,
//                              ),
//                              items: <String>['ذكر', 'انثي'].map((String value) {
//                                return DropdownMenuItem<String>(
//                                  child: new Text(value),
//                                  value: value,
//                                );
//                              }).toList(),
//                            ),
//                          ),

                        Padding(
                          padding: EdgeInsets.only(
                              left: 15, top: 0, right: 80, bottom: 20.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                new Text('النوع',
                                    style: TextStyle(
                                        color: third,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w900)),
                                new Radio(
                                  activeColor: prime,
                                  value: 0,
                                  groupValue: _gender,
                                  onChanged: _handleRadioValueChange1,
                                ),
                                new Text(
                                  'ذكر',
                                  style: TextStyle(color: third, fontSize: 20),
                                ),
                                new Padding(
                                  padding: new EdgeInsets.all(13),
                                ),
                                new Radio(
                                  activeColor: prime,
                                  value: 1,
                                  groupValue: _gender,
                                  onChanged: _handleRadioValueChange1,
                                ),
                                new Text(
                                  'أنثى',
                                  style: TextStyle(color: third, fontSize: 20),
                                ),
                              ]),
                        ),

                        Padding(
                          padding: EdgeInsets.only(
                              left: 15, top: 5, right: 0, bottom: 20.0),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              _displayImagesGridsfile(),
                              _displayImagesGridsCamera(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      persistentFooterButtons: <Widget>[
        Padding(
          // padding: EdgeInsets.symmetric(vertical: 20.0),
          padding: EdgeInsets.only(top: 0, bottom: 0, right: 0, left: 100.0),
          child: FlatButton(
            // padding: EdgeInsets.only(left: 30.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            color: second,
            textColor: third,
            onPressed: () {
              _emailSignUp(
                fname: _ChildFirstnameController.text,
                lname: _ChildFamilynameController.text,
                username: _ChildUserNameController.text,
                email: _ChildEmailController.text,
                password: _ChildPassWordController.text,
                phone: _ChildPhonenumberController.text,
                image: imageurl,
                gender: _gender,
                role: "1",
                context: context,
              );
             /* Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );*/
            },
            child: Text('إنشاء حساب',
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                 
                )),
          ),
        ),
      ],
      ),
    );
  }

  Future<void> _changeLoadingVisible() async {
    setState(() {
      _loadingVisible = !_loadingVisible;
    });
  }

  void _emailSignUp(
      {String fname,
      String lname,
      String username,
      String email,
      String password,
      String phone,
      String image,
      int gender,
      String role,
      BuildContext context}) async {
        if (_formkey.currentState.validate()) {
         if (_image1 != null) {
        imageurl = await UploadImage(_image1);
         } else if (_image4 != null) imageurl = await UploadImage(_image4);
        try {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        await _changeLoadingVisible();
        //need await so it has chance to go through error if found.
        await Auth.signUp(email, password).then((uId) {
          Auth.addUserSettingsDB(
            new User(
              uId: uId,
              fname: fname,
              lname: lname,
              username: username,
              image: imageurl,
              email: email,
              password: password,
              phone: phone,
              gender: gender,
              role: role,
            ),
          );
        });
      
        await Navigator.pushNamed(context, '/signin');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      } catch (e) {
        _changeLoadingVisible();
        print("فشل في الادخال: $e");

      }
    } else {
      setState(() => _autoValidate = true);
    }
  }

  //////////////////////////////
///// validation form///////
 String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "من فضلك ادخل البريد الالكتروني";
    } else if (!regExp.hasMatch(value)) {
      return "من فضلك ادخل بريد الكتروني متاح";
    } else {
      return null;
    }
  }
////////////////////////////
String validateName(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "من فضلك ادخل اسم المستخدم";
    } else if (!regExp.hasMatch(value)) {
      return "من فضلك ادخل اسم المستخدم";
    }if (value.length < 6){
      return 'يجب الا يقل اسم المستخدم عن 6 حروف وارقام';
      }

    return null;
  }
  //////////////////////
   String validateMobile(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "من فضلك ادخل رقم الهاتف";
    } else if (value.length != 11) {
      return "!!يجب ألا يقل رقم الهاتف عن 11 رقم";
    } else if (!regExp.hasMatch(value)) {
      return "!!يجب ان يكون رقم الهاتف ارقام فقط دون حروف";
    }
    return null;
  }
  ///////////
  
  Widget _loading() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

import 'package:gpproject/models/court.dart';
import 'package:gpproject/util/auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'login.dart';
import 'package:image_picker/image_picker.dart';

class SignUpCourt extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _SignUpCourt();
  }
}

class _SignUpCourt extends State<SignUpCourt> {
  bool isloading = false;
  File _image1, _image2, _image3, _image4;
  String imageurl;
  // Uri
  String downloadUrl, _name, _username, _password, _email;

  //final userrefrence = Firestore.instance.collection('Court');
  TextEditingController _ChildUserNameController = TextEditingController();
  TextEditingController _ChildEmailController = TextEditingController();
  TextEditingController _ChildNameController = TextEditingController();
  TextEditingController _ChildPassWordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool _loadingVisible = false;

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
    _ChildPassWordController.dispose();
    _ChildNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: ListView(
        children: <Widget>[
          new Container(
            color: prime,
            child: new Column(
              children: <Widget>[
                new Card(
                  margin: EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 30, bottom: 0),
                  child: new Form(
                    key: _formkey,
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                            controller: _ChildNameController,
                            keyboardType: TextInputType.emailAddress,
                            autofocus: true,
                            textDirection: TextDirection.rtl,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                color: third,
                                fontSize: 18,
                              ),
                              alignLabelWithHint: true,
                              hintText: "اسم المحكمة",
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
                            onSaved: (input) => _name = input,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 15, top: 10, right: 0, bottom: 20.0),
                          child: TextFormField(
                            controller: _ChildUserNameController,
                            keyboardType: TextInputType.emailAddress,
                            autofocus: true,
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
                            autofocus: true,
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
                            keyboardType: TextInputType.emailAddress,
                            autofocus: true,
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
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'من فضلك ادخل كلمة المرور';
                              }
                              if (value.length < 8) {
                                return 'كلمة المرور يجب الا تقل عن ثماني ارقام او حروف';
                              }
                              return null;
                            },
                            onSaved: (input) => _password = input,
                          ),
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
          padding: EdgeInsets.only(top: 0, bottom: 0, right: 0, left: 100.0),
          child: FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            color: second,
            textColor: third,
            onPressed: () {
              _emailSignUp3(
                name: _ChildNameController.text,
                username: _ChildUserNameController.text,
                email: _ChildEmailController.text,
                password: _ChildPassWordController.text,
                image: imageurl,
                role: "3",
                context: context,
              );
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
            child: Text('إنشاء حساب',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                )),
          ),
        ),
      ],
    );
  }

  Future<void> _changeLoadingVisible() async {
    setState(() {
      _loadingVisible = !_loadingVisible;
    });
  }

  void _emailSignUp3(
      {String name,
      String username,
      String email,
      String password,
      String image,
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
        await Auth.signUp(email, password).then((cId) {
          Auth.addUserSettingsDB3(
            new Court(
              cId: cId,
              name: name,
              username: username,
              image: imageurl,
              email: email,
              password: password,
              role: role,
            ),
          );
        });
        //now automatically login user too
        //await StateWidget.of(context).logInUser(email, password);
        await Navigator.pushNamed(context, '/signin');
      } catch (e) {
        _changeLoadingVisible();
        print("Sign Up Error: $e");
      }
    } else {
      setState(() => _autoValidate = true);
    }
  }

  //////////////////////////////
///// validation form///////
  ///valid email//
  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty) return 'من فضلك ادخل البريد الالكتروني ';
    if (!regex.hasMatch(value)) return 'من فضلك ادخل بريد الكتروني متاح';

/////////////////////////////////////////
  }

  //validate username//
  String validateName(String value) {
    if (value.isEmpty) return 'من فضلك ادخل اسم المستخدم';
    if (value.length < 6)
      return 'يجب الا يقل اسم المستخدم عن 6 حروف وارقام';
    else
      return null;
  }

////////////////////////////

  Widget _loading() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

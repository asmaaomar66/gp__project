import 'package:gpproject/models/lawyer.dart';
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

class SignUpLawyer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _SignUpLawyer();
  }
}

class _SignUpLawyer extends State<SignUpLawyer> {
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
      _officenumber,
      _officeaddress,
      _personaladdress,
     // _category,
      _selectedCategory;
      
  // final userrefrence = Firestore.instance.collection('Lawyer');
  TextEditingController _ChildUserNameController = TextEditingController();
  TextEditingController _ChildEmailController = TextEditingController();
  TextEditingController _ChildFirstnameController = TextEditingController();
  TextEditingController _ChildFamilynameController = TextEditingController();
  TextEditingController _ChildPhonenumberController = TextEditingController();
  TextEditingController _ChildOfficenumberController = TextEditingController();
  TextEditingController _ChildPersonaladdressController =
      TextEditingController();
  TextEditingController _ChildOfficeaddressController = TextEditingController();
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

  Widget _displayImagesGridsfile() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: IconButton(
                  icon: Icon(Icons.photo_filter , color: third,),
                  onPressed: () async {
                    var image = await ImagePicker.pickImage(
                        source: ImageSource.gallery);

                    setState(() {
                      _image1 = image;
                    });
                  }
              ),
            )
          ],
        )
      ],
    );
  }

  Widget _displayImagesGridsCamera() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: IconButton(
                  icon: Icon(Icons.camera_alt , color: third,),
                  onPressed: () async {
                    var image =
                    await ImagePicker.pickImage(source: ImageSource.camera);

                    setState(() {
                      _image4 = image;
                    });
                  }
              ),
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
    _ChildOfficeaddressController.dispose();
    _ChildOfficenumberController.dispose();
    _ChildPassWordController.dispose();
    _ChildPersonaladdressController.dispose();
  }

/*
  List<String> _Categories = [
    " الاسرة والاحوال الشخصية ",
    " الاندماج والتملك ",
    " الاعمال المصرفية والبنكية ",
    " تامين ",
    " دولي ",
    " العقود ",
    " شئون العمال ",
    " شئون بحرية ",
    " شئون ضريبية ",
    " شئون تجارية ",
    " شئون الهجرة ",
    " شئون الميراث ",
    " الملكية الفكرية ",
    " البناء والعقارات ",
    " عام ",
  ];

  _AddCategory() {
    _selectedCategory = _Categories[0];
  }*/

  @override
  Widget build(BuildContext context) {
    return  new Scaffold(
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
              //  color: third,
                margin: EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 30, bottom: 0),
                child: new Form(
                  key: _formkey,
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                   // controller: _scrollController,
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
                          //validator: validateName,
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
                         // validator: validateName,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'من فضلك ادخل اسم العائلة';
                            }
                            return null;
                          },
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
                          //obscureText: true,
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
                            hintText: " ادخل رقم الهاتف الشخصي",
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
                      Padding(
                        padding: EdgeInsets.only(
                            left: 15, top: 10, right: 0, bottom: 20.0),
                        child: TextFormField(
                          controller: _ChildOfficenumberController,
                          keyboardType: TextInputType.phone,
                          autofocus: false,
                          textDirection: TextDirection.rtl,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                              color: third,
                              fontSize: 18,
                            ),
                            alignLabelWithHint: true,
                            hintText: " ادخل رقم المكتب",
                            icon: new RawMaterialButton(
                              onPressed: () {},
                              child: new Icon(
                                Icons.phone,
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
                              return 'من فضلك ادخل رقم المكتب';
                            }
                            return null;
                          },*/
                          validator: validatephone,
                          onSaved: (input) => _officenumber = input,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 15, top: 10, right: 0, bottom: 20.0),
                        child: TextFormField(
                          controller: _ChildPersonaladdressController,
                          keyboardType: TextInputType.text,
                          autofocus: false,
                          textDirection: TextDirection.rtl,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                              color: third,
                              fontSize: 18,
                            ),
                            alignLabelWithHint: true,
                            hintText: " ادخل العنوان الشخصي",
                            icon: new RawMaterialButton(
                              onPressed: () {},
                              child: new Icon(
                                Icons.home,
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
                            if (input.length == 0) {
                             return "من فضلك ادخل العنوان";
                           } else if (input.isEmpty) {
                              return  'من فضلك ادخل العنوان';
                            }
                            return null;
                          },
                          onSaved: (input) => _personaladdress = input,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 15, top: 10, right: 0, bottom: 20.0),
                        child: TextFormField(
                          controller: _ChildOfficeaddressController,
                          keyboardType: TextInputType.text,
                          autofocus: false,
                          textDirection: TextDirection.rtl,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                              color: third,
                              fontSize: 18,
                            ),
                            alignLabelWithHint: true,
                            hintText: " ادخل عنوان المكتب",
                            icon: new RawMaterialButton(
                              onPressed: () {},
                              child: new Icon(
                                Icons.work,
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
                            if (input.length == 0) {
                             return "من فضلك ادخل عنوان المكتب";
                           } else if (input.isEmpty) {
                              return 'من فضلك ادخل عنوان المكتب';
                            }
                            return null;
                          },
                          onSaved: (input) => _officeaddress = input,
                        ),
                      ),
                    /*  Padding(
                        padding: EdgeInsets.only(
                            left: 15, top: 10, right: 90, bottom: 20.0),
                        child: DropdownButton<String>(
                          hint: Text('اختار التخصص',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black45,
                                  fontSize: 20)), // Not necessary for Option 1
                          value: _selectedCategory,
                          isExpanded: true,
                          icon: Icon(Icons.category , color: prime,),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: prime),
                          underline: Container(
                            height: 2,
                            color: prime,
                          ),
                          items: _Categories.map((category) {
                            return DropdownMenuItem<String>(
                              child: new Text(category),
                              value: category,
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              _selectedCategory = newValue;
                            });
                          },
                        ),
                      ),*/

                      Padding(
                        padding: EdgeInsets.only(
                            left: 15, top: 5, right: 0, bottom: 20.0),
                        child:  new Row(
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
          padding:
          EdgeInsets.only(top: 0, bottom: 0, right: 0, left: 100.0),
          child: FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            color: second,
            textColor: third,
            onPressed: () {
              _emailSignUp2(
                fname: _ChildFirstnameController.text,
                lname: _ChildFamilynameController.text,
                username: _ChildUserNameController.text,
                email: _ChildEmailController.text,
                password: _ChildPassWordController.text,
                phone: _ChildPhonenumberController.text,
                personaladdress: _ChildPersonaladdressController.text ,
                officeaddress: _ChildOfficeaddressController.text ,
                officenumber: _ChildOfficenumberController.text ,
                image: imageurl,
                category: _selectedCategory,
                role: "2",
                context: context,
              );
             /* Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );*/
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
  void _emailSignUp2(
      {
        String fname,
        String lname,
        String username,
        String email,
        String password,
        String phone,
        String personaladdress ,
        String officeaddress ,
        String officenumber ,
        String image,
        String category ,
        String role,
        BuildContext context
      }
      ) async {
    if (_formkey.currentState.validate()) {
       if (_image1 != null) {
      imageurl = await UploadImage(_image1);
    } else if (_image4 != null) imageurl = await UploadImage(_image4);
  
    try {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      await _changeLoadingVisible();
      //need await so it has chance to go through error if found.
      await Auth.signUp2(email, password).then(
            (id) {
          Auth.addUserSettingsDB2(
            new Lawyer(
              lId: id,
              fname: fname,
              lname: lname,
              username: username,
              email: email,
              password: password,
              phone: phone,
              personaladdress: personaladdress,
              officeaddress: officeaddress,
              officenumber: officenumber,
            //  category: category,
              image: imageurl,
              role: role,
            ),
          );
        },
      );
      //await Navigator.pushNamed(context, '/signin');
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

  Future<String> UploadImage(File image) async {
    String name = Random().nextInt(1000).toString() + '_child';
    final StorageReference storageReference =
        FirebaseStorage().ref().child(name);
    final StorageUploadTask UploadTask = storageReference.putFile(image);
    StorageTaskSnapshot respons = await UploadTask.onComplete;
    String URL = await respons.ref.getDownloadURL();

    return URL;
  }



  //////////////////////////////
///// validation form///////
  ///valid email//
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
  ////////////////

  //validate username//
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

   String validatephone(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "من فضلك يجب ادخال رقم الهاتف الخاص بالمكتب";
    } else if (value.length != 8) {
      return "!!يجب الا يقل رقم الهاتف عن 8 ارقام فقط ";
    } else if (!regExp.hasMatch(value)) {
      return "!!من فضلك يجب ان يكون رقم الهاتف ارقام فقط ";
    }
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


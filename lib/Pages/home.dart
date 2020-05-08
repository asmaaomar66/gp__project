import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
//import 'package:http/http.dart' as http;
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
import 'package:badges/badges.dart';
import 'package:gpproject/Classes/User.dart';
import 'package:gpproject/Classes/notification.dart';
import 'package:gpproject/Pages/questionPage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
//import 'package:gpproject/Pages/lawyerquestions.dart';
import 'package:gpproject/Pages/answerquestions.dart';
import 'package:gpproject/Pages/question_and_answer.dart';
import 'package:gpproject/Pages/question_list.dart';
import 'folderUpload.dart';
import 'package:gpproject/models/user.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'ProfileUsers.dart';
import 'clicky_button.dart';
import 'drawerprofile.dart';
import 'lawyer_list.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title, this.user, this.currentUser });
  final FirebaseUser user;
  final String title;
  final FirebaseUser currentUser;
  @override
  _MainPageState createState() => _MainPageState();
}
 TextEditingController _controller = TextEditingController();

    TextEditingController _new = TextEditingController();
var imp ;
  String pathPDF ;
bool loading = false;
var lol ;
class _MainPageState extends State<MainPage> {
String extension ;
bool loading = false ;
String name ;
  String pathPDF ;
  String _path;
  List<String> _extension;
  FileType _pickType = FileType.any ;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  List<StorageUploadTask> _tasks = <StorageUploadTask>[];
  final FirebaseAuth _auth = FirebaseAuth.instance;



  void openFileExplorer() async {
     
    try {
      _path = null;

        _path = await FilePicker.getFilePath(
            type: _pickType, allowedExtensions: _extension);
    
      
      uploadToFirebase();
      
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
    if (!mounted) return
    print("pug");
  }
 
  uploadToFirebase() {
   
     if (_path == null ){
print("no");

      } else{


setState(() {
  loading = true ;
});
      String fileName = _path.split('/').last;
      String filePath = _path;
      if(filePath == null ){
       print('noFilesUploaded');
      }
      else{
       upload(fileName, filePath);
    }}
  }
 
  upload(fileName, filePath) async{
    
    extension = fileName.toString().split('.').last;
    if(extension != "png" && extension != "jpg" && extension != "jpeg" && extension != "pdf" ){
showDialog<void>(
                    
context: context,
builder: (BuildContext context){  
  return 
  AlertDialog(
    title: new Text("لا تستطيع تحميل هذا النوع من الملفات", style: TextStyle(color: Colors.blue) ,),
    content:  Image.network("https://www.freeiconspng.com/uploads/alert-icon-with-exclamation-point--28.jpg" ),
    elevation:  24,
    backgroundColor: Colors.white,
  );

}                              
                            );          
                            loading = false;
    }
    else{
    name = fileName.toString().split('.').first;
    StorageReference storageRef =
        FirebaseStorage.instance.ref().child(fileName);
    final StorageUploadTask uploadTask = storageRef.putFile(
      File(filePath),
      StorageMetadata(
        contentType: '$_pickType/$_extension',),);
    
   
     StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    String url = (await downloadUrl.ref.getDownloadURL());
   
    final FirebaseUser user = await _auth.currentUser();

    if (extension == "pdf" )
    {
       DocumentReference ref = await Firestore.instance.collection('files').add(
                    {"name": name, "lawyerid": user.uid , "role" : "1"
                    ,
                    "filePath" : "12",
                     "url": url, "pic":"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRowcbzmDhboRH-3rBZKYQ4u0GB0YwC23YBmQ_ighuwRcFE0BJ5&usqp=CAU",
                    });
                lol = ref.documentID;
                Firestore.instance.collection("files").document(lol).updateData(
                    {"Address": lol});
    
    }
    else if( extension == "jpg" || extension == "jpeg" || extension== "png" ){
    DocumentReference ref = await
    Firestore.instance.collection('files').add({"role": "2" ,"url": url , "pic" : 'https://image.winudf.com/v2/image1/cGhvdG8uZ2FsbGVyeS5pbWFnZWVkaXRvcl9pY29uXzE1NTUxNDk0NTJfMDU1/icon.png?w=170&fakeurl=1'
    ,  'lawyerid' : user.uid , 'name' : name
     }); 
     lol = ref.documentID;
Firestore.instance.collection('files').document(lol).updateData({"Address" : lol});
    }
    else{
} 

  
      _tasks.add(uploadTask);

  
    

setState(() {
  loading = false;
});



    }
  }



  Future<void> _ackAlert(BuildContext context){
return showDialog<void>(
context: context,
builder: (BuildContext context){  
  return 
  AlertDialog(

title: Text("أتود إضافة ملف جديد أم مجلد ؟"), 
actions: <Widget>[
 RaisedButton.icon(icon: new Icon(Icons.folder, color: Colors.white,), label: Text("مجلد"),
 color: Colors.blue, onPressed:(){ Navigator.pop(context) ;  _chooseName(context);}),
RaisedButton.icon(icon: new Icon(Icons.add_photo_alternate, color: Colors.white,),label: Text("ملف"),
 color: Colors.blue, onPressed:(){
       Navigator.pop(context);
  openFileExplorer();
  
   
    }),

],
  );
  }
);

  }



 

  
  Future<void> _chooseName(BuildContext context){
    
return showDialog<void>(
context: context,
 
builder: (BuildContext context ){  
  return 
  AlertDialog(

title: Text("قم بتسميه المجلد من فضلك"),
content: new TextField(
controller: _controller,
maxLength: 10,
maxLengthEnforced: true,


 ),
actions: <Widget>[
 
IconButton(icon: new Icon(Icons.file_upload, color: Colors.black,),
 alignment: Alignment.topRight,color: Colors.teal[900], onPressed:()async{ Navigator.of(context).pop();
   DocumentReference ref = await Firestore.instance.collection('folder').add(
                    {"name": _controller.text, "lawyerid": widget.user.uid});
                imp = ref.documentID;
                Firestore.instance.collection("folder").document(imp).updateData(
                    {"Address": imp});

  }),

],
  );
  }
);

  }

   


  UserClass userClass = new UserClass();
  User user = new User();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
   final UserSnapshot = Firestore.instance;
  FirebaseUser firebaseUser;
  User currentUser = new User();

 NotificationClass noti = new NotificationClass();
  initUser() async {
    //firebaseUser = await _firebaseAuth.currentUser();
    //userID = firebaseUser.uid;
    currentUser = this.userClass.getCurrentUser();
    setState(() {});
  }

  User client = new User();
  ScrollController _scrollController = new ScrollController();
  final _formKey = GlobalKey<FormState>();
  Future _data;
  Future getClients() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore
        .collection("users")
        .where('role', isEqualTo: "1")
        .where('lawyerId', isEqualTo: widget.user.uid)
        .where('courtId', isEqualTo: widget.user.uid)
        .getDocuments();
    return qn.documents;
  }

/*  navigateToDetail(DocumentSnapshot user) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FbCprofileState(user: currentUser)),
    );
  }*/

  static Future<void> signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    FirebaseAuth.instance.signOut();
  }

  @override
  void initState() {
    super.initState();
    initUser();
    _data = getClients();
  }

  var m ;
void countDocumentLength() async {
    QuerySnapshot x = await Firestore.instance.collection("reading")
    .where("id", isEqualTo: widget.user.uid).getDocuments();
    List<DocumentSnapshot> _x = x.documents; 
    m =_x.length;
  }

  var b ;
void countDocumentLengthAnswer() async {
    QuerySnapshot x = await Firestore.instance.collection("answers").
    where("id", isEqualTo: widget.user.uid).getDocuments();
    List<DocumentSnapshot> _x = x.documents;
    b =_x.length;
  }

  Color prime = Colors.red[800] ;
  Color second = Colors.white ;
   int _page = 0 ;
   
  @override
  Widget build(BuildContext context) {
    countDocumentLength();
    countDocumentLengthAnswer();

    return new  Scaffold(
        drawer: drawerprofile(currentUser: widget.user),
        appBar: AppBar(
          title: new Icon(Icons.home , size: 20.0, color: second ),
           ),
       body: StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance
              .collection('users')
              .document(widget.user.uid)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              return checkRole(snapshot.data);
            }
            return CircularProgressIndicator();
          },
        ),
    );
  }
  FutureBuilder checkRole(DocumentSnapshot snapshot) {
    if (snapshot.data == null) {
      return FutureBuilder(
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text(" ...من فضلك انتظر قليلا"),
            );
          } else {
            return new Text('no data set in the userId document in firestore');
          }
        },
      );
    }
    if (snapshot.data['role'] == '1') {
      return userPage(snapshot) ;
            //return userPage(snapshot);
          } else if (snapshot.data['role'] == '2') {
            return createListView(snapshot);
            //return lawyerPage(snapshot);
          } else {
            return courtPage(snapshot);
          }
        }    
        FutureBuilder userPage(DocumentSnapshot snapshot) {
          return FutureBuilder(
              future: _data ,
              builder: (_, snapshot) {
                 if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Text("Loading ..."),
                  );
                } else {
                return new  Column(
                          children: <Widget>[
      
                             new  BottomNavigationBar(
                       currentIndex: _page,
                         items: [
                            BottomNavigationBarItem(
                             backgroundColor: prime,
                             icon: new Icon(Icons.person , color: second,),
                             title: new Text('الصفحة الشخصية' , style: new TextStyle(fontSize: 10.0 , color: second),)
                           ),
                           BottomNavigationBarItem(
                             backgroundColor: prime,
                             icon: new Icon(Icons.help , color: second,),
                             title: new Text('أسال الان؟' , style: new TextStyle(fontSize: 10.0 , color: second),)
                           ),

                           BottomNavigationBarItem(
                        backgroundColor: prime,
                         icon : new Badge(
                         animationType: BadgeAnimationType.slide,
                         badgeContent:  Text("$b"),
                       child: new Icon(Icons.question_answer , color: second,)),
                       title: new Text('الجواب' , style: new TextStyle(fontSize: 10.0 , color: second),)
                     ),
                           BottomNavigationBarItem(
                             backgroundColor: prime,
                             icon: new Icon(Icons.notifications_none , color: second,),
                             title: new Text('الاشعارات' , style: new TextStyle(fontSize: 10.0 , color: second),)
                           ),
                         ],
                          onTap: (index){
                   setState(() {
                     _page = index ; 
                    if(_page == 0){

                          Navigator.push(context, MaterialPageRoute(builder: (context) => profileUsers( currentUser: widget.user,)));             
                    }else if (_page == 1){
                   Navigator.push(context,MaterialPageRoute(builder: (context) =>  LawyerList(value: widget.user)));
                    }else if (_page == 2){
                          Navigator.push(context,  MaterialPageRoute(builder: (context) => QuestionAndAnswer(value: widget.user.uid, v: widget.user)));
                        Firestore.instance.collection("answers").where("id", isEqualTo: widget.user.uid).getDocuments().then((snapshot)
                        {for (DocumentSnapshot ds in snapshot.documents){ds.reference.delete();}});                

                    }else if (_page == 3){
                          Navigator.push(context,  MaterialPageRoute(builder: (context) => questionPage()));
                    }
                   });
                  },
                  ),
                 new Container(
                          child: Padding(
                          padding: EdgeInsets.only(
                              top: 30.0, bottom: 0.0, right: 10.0, left: 10.0),
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                     decoration: BoxDecoration(
                          border: Border.all(color: Colors.teal[900]),
                          borderRadius: BorderRadius.all(Radius.elliptical(30, 30)),
                          color: Colors.white70,
                        ),
                        margin: EdgeInsets.fromLTRB(20, 0, 20, 50),
                        padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                        child: new TextField(
                          style: TextStyle(),
                          textDirection: TextDirection.rtl,
                          autocorrect: true,
                          decoration: new InputDecoration(
                            border: InputBorder.none,
                            icon: new IconButton(
                                icon: new Icon(Icons.search), onPressed: null),
                            hintText: "ابحث عن رأي القانون في مشكلتك",
                          ),
                        )
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                ]
              );
                }
      
              });
        }
        FutureBuilder createListView(DocumentSnapshot snapshot) {
          return FutureBuilder(
              future: _data,
             
              builder: (_, snapshot) {
              //  _gettapbar1();
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Text(" من فضلك انتظر قليلا... "),
                  );
                } else {
                  return ListView(

                    children: <Widget>[
                       new  BottomNavigationBar(
                         backgroundColor: prime,
                       currentIndex: _page,
                         items: [
                            BottomNavigationBarItem(
                             backgroundColor: prime,
                             icon: new Icon(Icons.person , color: second,),
                             title: new Text('الصفحة الشخصية' , style: new TextStyle(fontSize: 10.0 , color: second),)
                           ),

                           BottomNavigationBarItem(
                         icon : new Badge(
                         animationType: BadgeAnimationType.slide,
                         badgeContent:  Text("$m"),
                         child: new Icon(Icons.question_answer , color: second, ),),
                         title: new Text('الجواب' , style: new TextStyle(fontSize: 10.0 , color: second),)
                     ),

                           BottomNavigationBarItem(
                             backgroundColor: prime,
                             icon: new Icon(Icons.notifications_none , color: second,),
                             title: new Text('الاشعارات' , style: new TextStyle(fontSize: 10.0 , color: second),)
                           ),
                         ],
                          onTap: (index){
                   setState(() {
                     _page = index ; 
                    if(_page == 0){

                     Navigator.push(context, MaterialPageRoute(builder: (context) => profileUsers(currentUser: widget.user,)));             
                    }else if (_page == 1){
                           Navigator.push(context,MaterialPageRoute(builder: (context) => QuestionList(value : widget.user.uid, v :widget.user)));
                           Firestore.instance.collection("reading").where("id", isEqualTo: widget.user.uid).getDocuments().then((snapshot)
                           {for (DocumentSnapshot ds in snapshot.documents){ds.reference.delete();}});

                    }else if (_page == 2){
                         Navigator.push(context,MaterialPageRoute(builder: (context) => questionPage()));
                    }
                   });
                  },
                  ),
                  
                         Container(
                      
                        child: Column(
                          children: <Widget>[
                          new Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.blue  
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.elliptical(30, 30)),
                                color: Color.fromARGB(100, 225, 225, 225)
                                    .withOpacity(0.3),
                              ),
                              
                              margin: EdgeInsets.fromLTRB(20, 15, 20, 50),
                              child: new TextField(
                                style: TextStyle(),
                                textDirection: TextDirection.rtl,
                                autocorrect: true,
                                
                                decoration: new InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "ابحث في ملفاتك و مجلداتك",
                                  icon: new IconButton(
                                      icon: new Icon(Icons.search), onPressed: null),
                                ),
                              )),
                          
                                                 
                            StreamBuilder<QuerySnapshot>(
                      stream:  
                      
                       Firestore.instance.collection('files').where('lawyerid' , isEqualTo: widget.user.uid ).snapshots(),
                       
                      builder: (context, snapshot) {
                           if(snapshot.hasError){
                             return Text("error");
                           }
                           if(snapshot.connectionState == ConnectionState.waiting){

                                                     return SpinKitRing(color: Colors.blueGrey, size: 50,);

                           }
                       
                        else{  
                          if(loading == false ){
                          return Material(
                           child:   new Column( 
                        
                            children: snapshot.data.documents.map((doc) {
                
              
                             return
                             
                               ListTile(title: Text(doc.data['name'],),
                               dense: true ,
                                leading: Tab(icon : new Image.network(doc.data['pic'],width: 35, ),),
                               trailing: IconButton(icon: Icon(Icons.more_vert ,color: Colors.blue,size: 20 ,) 
                               , onPressed: () {  showModalBottomSheet(
context: context, isScrollControlled: false,
builder: (BuildContext context){  
  return 
 
  Container( 
    color: Color(0xFF737373),
    height: 180,
    
    
    child: 
  Container ( 
    decoration: BoxDecoration(
     image: DecorationImage(image: NetworkImage("https://png.pngtree.com/thumb_back/fw800/background/20191017/pngtree-white-blue-flyer-transparent-paper-circle-frame-image_320021.jpg"),
                                fit: BoxFit.cover), 
      borderRadius: BorderRadius.only(
        topLeft: const Radius.circular(25),
        topRight: const Radius.circular(25),
      )
    ),
    child:
  Column(children: <Widget>[
   ListTile(
     title: Text("عرض"),
     trailing: Icon(Icons.open_in_new, color: Colors.black,),
     onTap: ()async{
        Navigator.of(context).pop();
             if(doc.data['role'] == "2"){
          showDialog<void>(
            barrierDismissible: false,
context: context,
builder: (context){  
  return 
  AlertDialog(
    title: RaisedButton (onPressed:(){ Navigator.pop(context);}, child: Icon(Icons.close, color: Colors.white, ),color: Colors.blue,),
titlePadding: EdgeInsets.fromLTRB(230, 0, 0, 0),
content:new SingleChildScrollView(child:  Image.network(doc.data['url'])));
         });}
   else{ 
       if(doc.data['filePath']== "12"){
       final url = doc.data['url'];
       final filename = url.substring(url.lastIndexOf("/") +1 );
       var request = await HttpClient().getUrl(Uri.parse(url));
       var response = await request.close();
       var bytes = await consolidateHttpClientResponseBytes(response);
       String dir = (await getApplicationDocumentsDirectory()).path;
       File file = new File('$dir/$filename');
         try{
          await file.writeAsBytes(bytes);}
          on FileSystemException catch (e){
          Text("the file is too big to load");

            }
  pathPDF = file.path;
  
  Firestore.instance.collection("files").where("Address", isEqualTo: doc.data['Address']).getDocuments().then((snapshot)
                           {for (DocumentSnapshot so in snapshot.documents){so.reference.updateData({'filePath': pathPDF});}});  
                                 Navigator.push(context,
                              MaterialPageRoute(builder: (context) => PDFScreen(pathPDF)));
                             }
   
   else{
       Navigator.
                              push(context,
                              MaterialPageRoute(builder: (context) => PDFScreen(doc.data['filePath'])));
   }
     }
     } 
   ),
   ListTile(
     title: Text("حذف"),
     trailing: Icon(Icons.delete,color: Colors.black,),

     onTap: (){
              Navigator.pop(context);

       Firestore.instance.collection("files").where("Address", isEqualTo: doc.data['Address']).getDocuments().then((snapshot)
                           {for (DocumentSnapshot lo in snapshot.documents){lo.reference.delete();}});},
   ),
ListTile(
  title: Text("تعديل الاسم",),
  trailing: Icon(Icons.edit,color: Colors.black,),

  onTap: (){
           Navigator.pop(context);

    showDialog<void>(
context: context,
builder: (BuildContext context){  
  return 
  AlertDialog(

title: Text("الاسم الجديد"),
content: new TextField(
controller: _new,

 ),
actions: <Widget>[
 
IconButton(icon: new Icon(Icons.edit, color: Colors.black,),
 alignment: Alignment.topRight,color: Colors.teal[900], onPressed:(){ Navigator.of(context).pop();
Firestore.instance.collection("files").where("Address", isEqualTo: doc.data['Address']).getDocuments().then((snapshot)
                           {for (DocumentSnapshot lo in snapshot.documents){lo.reference.updateData({'name': _new.text});}});
  }),

],
  );
  }
);},
   ),

 ],)));

  }
);

                               }), 

                                 onTap: ()async {
                                                            
                  if(doc.data['role']== "1"){
                           
                         if(doc.data['filePath'] == "12"){
                             
    final url = doc.data['url'];
    final filename = url.substring(url.lastIndexOf("/") +1 );
    var request = await HttpClient().getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$filename');
    try{
    await file.writeAsBytes(bytes);}
    on FileSystemException catch (e){
    Text("the file is too big to load");

    }
  pathPDF = file.path;
  print(pathPDF);
Firestore.instance.collection("files").where("Address", isEqualTo: doc.data['Address']).getDocuments().then((snapshot)
                           {for (DocumentSnapshot no in snapshot.documents){no.reference.updateData({'filePath': pathPDF});}});  
                                 Navigator.
                              push(context,
                              MaterialPageRoute(builder: (context) => PDFScreen(pathPDF)));
  
                  }
                  else{
                     Navigator.
                              push(context,
                              MaterialPageRoute(builder: (context) => PDFScreen(doc.data['filePath'])));
                  }}
 
    
  
else if(doc.data['role'] == "2"){

  
      showDialog<void>(
                    barrierDismissible: false,
context: context,
builder: (BuildContext context){  
  return 
  AlertDialog(
title: FlatButton(onPressed:(){ Navigator.pop(context);}, child: Icon(Icons.close, color: Colors.white, ), color: Colors.blue),
titlePadding: EdgeInsets.fromLTRB(230, 0, 0, 0),
content:new SingleChildScrollView(child:  Image.network(doc.data['url'])));
         });
  } 

                              

else{
ListTile(title:Text("you can't upload that kind of files, you can only upload pdf or images "));
  



}                              
                               }
                        
                            );
                                                                }
                                      
                            ).toList(),

                        
                           )   );}
                           else{
                             return SpinKitRing(color: Colors.blueGrey);
                           
                          }
                      }
                      }
                       ), 

   StreamBuilder<QuerySnapshot>(
       
                      stream:  Firestore.instance.collection('folder').where('lawyerid' , isEqualTo: widget.user.uid).snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Material(
                           child:   new Column(
                            children: snapshot.data.documents.map((doc) {
                              return
                             
                               ListTile(title: Text(doc.data['name'],),
                               leading: Icon(Icons.folder,color: Colors.amber[300],size: 40 , ),
                               dense: true,
                            trailing: IconButton(icon: Icon(Icons.more_vert ,color: Colors.blue,size: 20 ,) 
                               , onPressed: () {  showModalBottomSheet(
context: context, isScrollControlled: false,
builder: (BuildContext context){  
  return 
 
  Container( 
    color: Color(0xFF737373),
    height: 180,
    
    
    child: 
  Container ( 
    decoration: BoxDecoration(
     image: DecorationImage(image: NetworkImage("https://png.pngtree.com/thumb_back/fw800/background/20191017/pngtree-white-blue-flyer-transparent-paper-circle-frame-image_320021.jpg"),
                                
                                fit: BoxFit.cover), 
      borderRadius: BorderRadius.only(
        topLeft: const Radius.circular(25),
        topRight: const Radius.circular(25),
      )
    ),
    child:Column(children: <Widget>[
   ListTile(onTap: (){
                Navigator.pop(context);

      Navigator.push(context,MaterialPageRoute(builder: (context) => UploadFolder(address: doc.data['Address'], nam: doc.data['name'])));
  },
   
   title : Text("عرض"),
        trailing: Icon(Icons.open_in_new, color: Colors.black,),

   ),
   
   ListTile(onTap: (){
                Navigator.pop(context);

     Firestore.instance.collection("folder").where("Address", isEqualTo: doc.data['Address']).getDocuments().then((snapshot)
                           {for (DocumentSnapshot lo in snapshot.documents){lo.reference.delete();}});},
  title : Text("حذف"),
       trailing: Icon(Icons.delete, color: Colors.black,),

  ),
  
   
ListTile(onTap: (){
             Navigator.pop(context);

  showDialog<void>(
context: context,
builder: (BuildContext context){  
  return 
  AlertDialog(

title: Text("الاسم الجديد"),
content: new TextField(
controller: _new,

 ),
actions: <Widget>[
 
IconButton(icon: new Icon(Icons.edit, color: Colors.black,),
 alignment: Alignment.topRight,color: Colors.teal[900], onPressed:(){Navigator.of(context).pop(); 
Firestore.instance.collection("folder").where("Address", isEqualTo: doc.data['Address']).getDocuments().then((snapshot)
                           {for (DocumentSnapshot lo in snapshot.documents){lo.reference.updateData({'name': _new.text});}});
  }),

],
  );
  }
);},
   title: Text("تعديل الاسم"),
        trailing: Icon(Icons.edit, color: Colors.black,),

   ),

 ],),

 ),


  );
  }
);

                               }), 
                               onTap: (){ 

 Navigator.push(context,MaterialPageRoute(builder: (context) => UploadFolder(address: doc.data['Address'], nam: doc.data['name'])));

                               },
                              

                           
                              );
                            }).toList(),


                           )   );
                        }
                        else {
                          return SizedBox();
                        }
                      } ),
                             

                                  
                                 
                                 
              


          

                           
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Material(
                                type: MaterialType.transparency,
                                child: new
                                 FloatingActionButton(
                                  onPressed: () {_ackAlert(context);},
                                  child: new Icon(
                                    Icons.add, 
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  backgroundColor: Colors.blue
                              )),
                          )
                        ]
                      
                      ),
                      )
                      ],
                  );
                }
              });
        }
        FutureBuilder courtPage(DocumentSnapshot snapshot) {
          return FutureBuilder(
              future: _data,
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Text(" من فضلك انتظر قليلا... "),
                  );
                } else {
                  return Column(
                    children: <Widget>[
                       new  BottomNavigationBar(
                         backgroundColor: prime,
                       currentIndex: _page,
                         items: [
                            BottomNavigationBarItem(
                             backgroundColor: prime,
                             icon: new Icon(Icons.perm_identity , color: second,),
                             title: new Text('الصفحة الشخصية' , style: new TextStyle(fontSize: 10.0 , color: second),)
                           ),
                            BottomNavigationBarItem(
                             backgroundColor: prime,
                             icon:  new Icon(Icons.add_circle_outline , color: second,),
                             title: new Text('اضافة قضية' , style: new TextStyle(fontSize: 10.0 , color: second),)
                           ),
                           BottomNavigationBarItem(
                             backgroundColor: prime,
                             icon: new Icon(Icons.notifications_none , color: second,),
                             title: new Text('الاشعارات' , style: new TextStyle(fontSize: 10.0 , color: second),)
                           ),
                         ],
                          onTap: (index){
                   setState(() {
                     _page = index ; 
                    if(_page == 0){

                          Navigator.push(context, MaterialPageRoute(builder: (context) => profileUsers(currentUser: widget.user,)));             

                    }else if (_page == 1){
                    Navigator.push(context,MaterialPageRoute(builder: (context) => questionPage()));
                    }else if (_page == 2){
                         Navigator.push(context,MaterialPageRoute(builder: (context) => questionPage()));
                    }
                   });
                  },
                  ),
                      new Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.brown),
                            borderRadius: BorderRadius.all(Radius.elliptical(30, 30)),
                            color: Colors.white70,
                          ),
                          margin: EdgeInsets.fromLTRB(20, 20, 20, 50),
                          padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                          child: new TextField(
                            style: TextStyle(),
                            textDirection: TextDirection.rtl,
                            autocorrect: true,
                            decoration: new InputDecoration(
                              border: InputBorder.none,
                              icon: new IconButton(
                                  icon: new Icon(Icons.search), onPressed: null),
                              hintText: "ابحث عن اسم أو رقم تسلسل القاضية ",
                            ),
                          )),
                      Container(
                        height: 90,
                        margin: EdgeInsets.fromLTRB(0, 5, 5, 0),
                        child: new Stack(
                          children: <Widget>[
                            new Container(
                              height: 124,
                              margin: const EdgeInsets.only(left: 46),
                              // child: Text("الاسم", textDirection: TextDirection.rtl,),
                              decoration: new BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25.0),
                                  bottomRight: Radius.circular(25.0),
                                  bottomLeft: Radius.circular(25.0),
                                ),
                              ),
                            ),
                            new Container(
                                height: 120,
                                width: 120,
                                margin: EdgeInsets.fromLTRB(20, 10, 180, 0),
                                // margin:  EdgeInsets.symmetric(  horizontal: 20,vertical: 20 ,),
                                alignment: FractionalOffset.centerLeft,
                                child: new CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: NetworkImage(
                                      "http://photo.elcinema.com.s3.amazonaws.com/uploads/_315x420_af94736653749ad01096cd6e2757e6489a8750dc5334bb6a0bb9cf8e428d4cc0.jpg"),
                                )),
                            new Positioned(
                              right: 10,
                              bottom: 25,
                              child: IconButton(
                                  iconSize: 30,
                                  icon: Icon(
                                    Icons.more,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (_) => Stack(children: <Widget>[
                                              AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                content: SingleChildScrollView(
                                                    child:
                                                        ListBody(children: <Widget>[
                                                  new Text(
                                                    'الاسم',
                                                    textAlign: TextAlign.right,
                                                    textDirection: TextDirection.rtl,
                                                  ),
                                                  new Text(
                                                    'رقم التسلسل',
                                                    textAlign: TextAlign.right,
                                                    textDirection: TextDirection.rtl,
                                                  ),
                                                  new Text(
                                                    'عنوان المكتب',
                                                    textAlign: TextAlign.right,
                                                    textDirection: TextDirection.rtl,
                                                  ),
                                                  new Text(
                                                    'عنوانه الخاص',
                                                    textAlign: TextAlign.right,
                                                    textDirection: TextDirection.rtl,
                                                  ),
                                                  new Text(
                                                    'رقم الهاتف',
                                                    textAlign: TextAlign.right,
                                                    textDirection: TextDirection.rtl,
                                                  ),
                                                  new Text(
                                                    'رقم البطاقة',
                                                    textAlign: TextAlign.right,
                                                    textDirection: TextDirection.rtl,
                                                  ),
                                                  new Text(
                                                    'رقم كارنية النقابة',
                                                    textAlign: TextAlign.right,
                                                    textDirection: TextDirection.rtl,
                                                  ),
                                                ])),
                                                actions: <Widget>[
                                                  Transform.scale(
                                                    alignment: Alignment.bottomCenter,
                                                    scale: 0.5,
                                                    child: ClickyButton(
                                                      child: Text(
                                                        'تعديل',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 35),
                                                      ),
                                                      color: Colors.green,
                                                      onPressed: () {},
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Positioned(
                                                  left: 126,
                                                  top: 35,
                                                  child: new CircleAvatar(
                                                    radius: 50,
                                                    backgroundImage: NetworkImage(
                                                        "http://photo.elcinema.com.s3.amazonaws.com/uploads/_315x420_af94736653749ad01096cd6e2757e6489a8750dc5334bb6a0bb9cf8e428d4cc0.jpg"),
                                                    backgroundColor:
                                                        Colors.transparent,
      
                                                    // backgroundColor: Colors.white,
                                                  ))
                                            ]));
                                  }),
                            ),
                            new Positioned(
                                right: 65,
                                bottom: 50,
                                child: Text(
                                  ":الاسم",
                                  style:
                                      TextStyle(fontSize: 20, color: Colors.black54),
                                )),
                            new Positioned(
                                right: 65,
                                bottom: 10,
                                child: Text(
                                  ":رقم التسلسل",
                                  style:
                                      TextStyle(fontSize: 20, color: Colors.black54),
                                )),
                          ],
                        ),
                      )
                    ],
                  );
                }
              });
        }

    }
    /*class DynamicWidget extends StatelessWidget{
        

  @override



  var x = _controller.text ;
  
  Widget build(BuildContext context) {
    return Container( 
  height: 70,    
         width: 70,
                                       //   margin:
                                         //     EdgeInsets.symmetric(horizontal: 3.0),
                                          decoration: BoxDecoration(
                                            color: Color.fromARGB(100, 225, 225, 225)
                                                .withOpacity(0.3),
                                            borderRadius: BorderRadius.all(
                                               Radius.elliptical(30, 30)),
                                         ),
      child: 
     ListView(children: <Widget>[
       IconButton(icon: new Icon(Icons.folder,color: Colors.yellowAccent,size: 70 , ), //padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 0.0),
        onPressed:(){ 
       Navigator.of(context).push((MaterialPageRoute(builder: (context)=> UploadFolder( parameter: 5 , address : imp))));
     }),
   new FlatButton(child: new Text("$x"), color: Colors.white,  ), // i will put here a code of retrieve name so i could change it
    ])
    
    
    );
  }



  }*/

class PDFScreen extends StatelessWidget { // new page presents the pdf 
  String pathPDF ;
  
  PDFScreen(this.pathPDF);

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
        appBar: AppBar(
          title: Text("الملف"),
         
        ),
        path: pathPDF,
        
        );
  }
}
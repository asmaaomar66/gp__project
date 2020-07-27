import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
//import 'package:http/http.dart' as http;
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_plugin.dart';



class UploadFolder extends StatefulWidget {
  var parameter ;
  var address ;

  UploadFolder({Key key ,this.parameter, this.address, this.nam}) : super(key: key);

 var nam; 
  @override     

  _UploadFolder createState() => _UploadFolder();
}
 
class _UploadFolder extends State<UploadFolder>  {


String extension ;
bool loading = false ;
String name ;
  String pathPDF ;
  String _path;
  List<String> _extension; // = ['jpg', 'pdf', 'png', 'jpeg'];
  FileType _pickType = FileType.any ;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  List<StorageUploadTask> _tasks = <StorageUploadTask>[];
    TextEditingController _new = TextEditingController();
bool wait ;
  
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
      // StorageTaskEventType.resume ?? SpinKitDualRing(color: Colors.amber,);
    final StorageUploadTask uploadTask = storageRef.putFile(
      File(filePath),
       
      StorageMetadata(
        contentType: '$_pickType/$_extension',
        
      ),
     

    
    );
    
   
     StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
     
    String url = (await downloadUrl.ref.getDownloadURL());
    
 


    if (extension == "pdf" )
    {
      
    DocumentReference ref = await Firestore.instance.collection('folder').document(widget.address).collection('files').add
    ({"role": "1" ,"url": url ,
    'name' : name,
                        "filePath" : "12",

     "pic" : "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRowcbzmDhboRH-3rBZKYQ4u0GB0YwC23YBmQ_ighuwRcFE0BJ5&usqp=CAU" });
     String lol = ref.documentID;
     Firestore.instance.collection('folder').document(widget.address).collection('files').document(lol).updateData( {"Address": lol});
    }
    else if( extension == "jpg" || extension == "jpeg" || extension == "png"){
    
   DocumentReference ref = await Firestore.instance.collection('folder').document(widget.address).collection('files').add
   ({"role": "2" ,"url": url ,
       'name' : name,
    "pic" : 'https://image.winudf.com/v2/image1/cGhvdG8uZ2FsbGVyeS5pbWFnZWVkaXRvcl9pY29uXzE1NTUxNDk0NTJfMDU1/icon.png?w=170&fakeurl=1' });
     String lol = ref.documentID;
     Firestore.instance.collection('folder').document(widget.address).collection('files').document(lol).updateData( {"Address": lol});
    }
    else{
  Text("you can't upload that kind of files");
    } 



  
    
      _tasks.add(uploadTask);




setState(() {
  loading = false;
});

  }


  }
 
  /*String _bytesTransferred(StorageTaskSnapshot snapshots) {
    return '${snapshots.bytesTransferred}/${snapshots.totalByteCount}';
  }*/
 
  
 
    @override
  Widget build(BuildContext context) {
    

  
  
    return 
     
     new Scaffold(
     
        appBar: new AppBar(
          title: Text("${widget.nam}"),
        ),
        body: new ListView(children: <Widget>[ Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
           // crossAxisAlignment: CrossAxisAlignment.start,
          //  mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
      
             
     
                StreamBuilder<QuerySnapshot>(
                      stream:  
                      
                       Firestore.instance.collection('folder').document(widget.address).collection('files').snapshots(),
                       
                      builder: (context, snapshot) {
                           if(snapshot.hasError){
                             return Text("error");
                           }
                           if(snapshot.connectionState == ConnectionState.waiting){

                             return Center(child: SpinKitFadingCube(color: Colors.blueAccent,), heightFactor: 10,);
                           }
                        //if (snapshot.hasData ) {
                        else{ if(loading == false){  
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
       Navigator.of(context).pop(true);
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

    
  pathPDF = file.path;}
  
  Firestore.instance.collection('folder').document(widget.address).collection('files').where("Address", isEqualTo: doc.data['Address']).getDocuments().then((snapshot)
           {for (DocumentSnapshot so in snapshot.documents){so.reference.updateData({'filePath': pathPDF});}});
            
          
      
       
                                 Navigator.
                              push(context,
                              MaterialPageRoute(builder: (context) => PDFScreen(pathPDF)));}
                              
                              
   
   else{
       Navigator.push(context, MaterialPageRoute(builder: (context) => PDFScreen(doc.data['filePath'])));
   }
     }
     
     }),
   ListTile(
     title: Text("حذف"),
     trailing: Icon(Icons.delete,color: Colors.black,),

     onTap: (){
              Navigator.pop(context);

                        Firestore.instance.collection('folder').document(widget.address).collection('files').where("Address", isEqualTo: doc.data['Address']).getDocuments().then((snapshot)
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
        Firestore.instance.collection('folder').document(widget.address).collection('files').where("Address", isEqualTo: doc.data['Address']).getDocuments().then((snapshot)
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
                        Firestore.instance.collection('folder').document(widget.address).collection('files').where("Address", isEqualTo: doc.data['Address']).getDocuments().then((snapshot)
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
                             return Center(child: SpinKitFadingCube(color: Colors.blueAccent,), heightFactor: 10,);
                           
                          }
                      }
                      }
                       ), 
             
                      
                FloatingActionButton(child: new Icon(Icons.add, color: Colors.white, ),
    /*padding: EdgeInsets.symmetric(vertical: 50.0,horizontal: 20.0),*/ backgroundColor: Colors.blue, onPressed:(){openFileExplorer(); }),
              
            ],
          ),
        ),])
     // ),
    );
  }
}
class PDFScreen extends StatelessWidget { // new page presents the pdf 
  String pathPDF ;
  
  PDFScreen(this.pathPDF);

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(

        appBar: AppBar(
          title: Text("ملفك"),
         
        ),
        
        
        path: pathPDF,
        
        );
  }
}
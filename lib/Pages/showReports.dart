import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'HelloApp.dart';
import 'Rules.dart';
import 'manage_courts.dart';
import 'manage_lawyers.dart';

class showReports extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _showReportsState();
  }

}

class _showReportsState extends State<showReports>{
  //------------------------Variables------------------------------
  //var totalEquals;
    Color prime = Color(0xff0e243b);
  Color second = Colors.white ;
  Color third =  Color(0xff0ccaee) ;

  final a = Firestore.instance;
  
   static Future<void> signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    FirebaseAuth.instance.signOut();
  }

  //-------------------------------------Functions- Widgets-------------------------
   Widget _topTwoBtn(){
     return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 15.0),
      child: Row(
        children: <Widget>[
           SizedBox(width: 30.0,),
          Expanded(
            child: InkWell(
              onTap: (){},
              child: Container(
                height: 40,
                width: 60,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  color: Colors.grey.shade500
                ),
                child: Center(
                  child:  Text(
                    ' الأكثر تفاعلاً',
                    style: TextStyle(
                      fontSize: 25,
                      color: prime,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ),
            ),
          ),
          SizedBox(width: 30.0,),
           ],
      ),
    );
  
  } 
  
  _onTapCell(lawyerName , lawyerId){
    
   showDialog<void>(
     context: context,
     builder: (BuildContext context) {
       return AlertDialog(
         title: Text('عدد الأسئله المُجاب عنها من ${lawyerName}'),
         content: _contentOfDialog(lawyerId),
           actions: <Widget>[
             IconButton(
               icon: new Icon(Icons.rate_review, color: third,size: 35, ),
             alignment: Alignment.topRight,color: prime,
               onPressed:(){
                 Navigator.pop(context);
                 },
               
             )
           ],
       );
      }
   );
  }

_contentOfDialog(lawyerId){
  var x;
  x = m ;
countDocumentLength(lawyerId);

if (m == null){
  return CircularProgressIndicator();
}
else {
return Text('${m} سؤالٍ'); }
}
 var m ;
 QuerySnapshot x ;
void countDocumentLength(lawyerId) async {
   x = await Firestore.instance.collection("info")
    .where("lawyerid", isEqualTo: lawyerId)
    .where('state', isEqualTo: '     تمت الإجابة عن هذا السؤال   ').getDocuments();

    List<DocumentSnapshot> _x = x.documents; 
    m =_x.length;
  }
  @override
  Widget build(BuildContext context) {
  //---------------------------------Begin of Scafold---------------------------------
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        //--------------------------Drawer-------------------------------
          drawer: new Drawer(
            child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              color: Theme.of(context).primaryColor,
              child: Center(
                child: Column(
                  children: <Widget>[
                     Container(
                      width: 100,
                      height: 100,
                    ),
                    Text('admin2020@gmail.com',
                        style: TextStyle(fontSize: 22, color:second)),
                    
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.supervised_user_circle,
                size: 25,
                color: third,
              ),
              title: Text(
                'إدارة_المُحامين',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => managelawyers()));
              },
            ),
            ListTile(
              leading: Icon(Icons.markunread_mailbox , color: third,),
              title: Text(
                'إدارة_المحاكم',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => managecourts()));
              },
            ),
            ListTile(
              leading: Icon(Icons.warning , color: third,),
              title: Text(
                'إدارة_القوانين',
                style: TextStyle(fontSize: 22 , ),
              ),
              onTap: () {
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Rules()));
              },
            ),
    //-------------------Show Reports--------------------------------------
              ListTile(
              leading: Icon(Icons.show_chart , color: third,),
              title: Text(
                'عرض_التقارير',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {
                  Navigator.push(context,new MaterialPageRoute(
                          builder:(context)=>showReports()
                      ));
              },
            ),
    //--------------------------------------------------------------------
             ListTile(
              leading: Icon(Icons.exit_to_app , color: third,),
              title: Text(
                'تسجيل الخروج',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {
                signOut();
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => HelloApp()));
              },
            ),
          ],
        ),
        ),
        //----------------------AppBar-----------------------------------
        appBar: AppBar(
          title: Text( 'التقارير',style: TextStyle(fontSize: 22), ),
           ),
        //----------------------Body-----------------------------------------
        body:  StreamBuilder<QuerySnapshot>(
         stream:  a.collection('users').where("role", isEqualTo: "2").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return new Container(
               padding: EdgeInsets.only(left: 5, right: 20, top: 10, bottom: 10.0),
               child: Column(children: <Widget>[
                 
                 DataTable(
                   columns: [
                     DataColumn(
                       label: Text('اسم المحامي', 
                       style: TextStyle(color: prime,fontSize: 17,fontWeight: FontWeight.w500),),
                       numeric: false,
                       tooltip: 'اسم المحامِ',
                      ),
                     
                   ],
                   rows:  snapshot.data.documents.map(
                     (DocumentSnapshot doc) =>DataRow(cells: [
                       DataCell(
                         Text('${doc.data['username']}'),
                         onTap : (){
                           _onTapCell(doc.data['username'] , doc.data['id']);
                         }

                       ),
                     
                     ])
                     ).toList()
                 ),
                 _topTwoBtn(),

               ],),
            );
            
          }
          else {
         return SizedBox();
             }
        } ,
        ),    

  
        ),
    );   
  }

}
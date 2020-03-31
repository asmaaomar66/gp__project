import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'questionPage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class lawyerScreen extends StatefulWidget{
  //----------------------Constractor---------
 lawyerScreen({this.currentLawyer, this.user, this.id});
    var currentLawyer;
    FirebaseUser user ;
    String id ;
  //---------------function-------------
  State<StatefulWidget> createState() {
    return new _stateLawyerScreen();
    
  }
}
class _stateLawyerScreen extends State<lawyerScreen>{

 //======================كل الي جاي عباره عن ويدجيتز بيتندهه عليها  جوا الاسكافولد=================
 Widget _buildCoverImage(Size screenSize){
    return Container(
      height: screenSize.height / 2.6,
      decoration: BoxDecoration(
       color: Colors.grey[500]
      ),
    );
  }//for build cover image 

  Widget _buildProfileImage(){
    return Center(
      child: Container(
        width: 140,
        height: 140,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('${widget.currentLawyer.data['image']}'),
                            fit: BoxFit.fill),
          borderRadius: BorderRadius.circular(80.0),
          border: Border.all(
            color: Colors.white,
            width: 10,
          )
        ),
      ),
    );
  }

  Widget _buildFullName(){
    TextStyle _nameTextStyle  = TextStyle(
      color: Colors.black,
      fontSize: 28,
      fontWeight: FontWeight.w700,
    );
    return Text(
     widget.currentLawyer.data['fname'] +' '+ widget.currentLawyer.data['lname'] ,
      style: _nameTextStyle,
    );
  }

  Widget _buildLawyerNumber(BuildContext context){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.0,horizontal: 3.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(4.0)
      ),
      child: Text(
        'رقم المكتب :${widget.currentLawyer.data['officenumber']}',
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  Widget _buildStatContainer(){
    TextStyle _statLabelTextStyle = TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.w200,
    );
    TextStyle _statCountTextStyle = TextStyle(
      color: Colors.black54,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    );
    return Container(
      height: 60,
      margin: EdgeInsets.only(top: 8.0),
      decoration: BoxDecoration(
        color: Color(0XFFEFF4F7),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildStatItem('Followers', '200'),
          _buildStatItem('Following', '200'),
          _buildStatItem('questions', '200')

        ],
      ),
    );

  }

  Widget _buildStatItem(String label, String count){
    TextStyle _statLabelTextStyle = TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.w200,
    );
    TextStyle _statCountTextStyle = TextStyle(
      color: Colors.black54,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    );
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          count,
          style: _statCountTextStyle,
        ),
        Text(
          label,
          style: _statLabelTextStyle,
        )
      ],
    );
  }

  Widget _buildOfficeAddress(BuildContext context){
    TextStyle aboutTextStyle = TextStyle(
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.italic,
      color: Color(0XFF799497),
      fontSize: 16,
    );
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.all(8.0),
      child: Text(
        'عنوان مكتب المحاماه: ${widget.currentLawyer.data['officeaddress']}',
        textAlign: TextAlign.center,
        style: aboutTextStyle,
      ),
    );
  }

  Widget _buildSeparator(Size screenSize, BuildContext context){
    return Container(
      width: screenSize.width / 1.6,
      height: 2.0,
      color: Colors.black54,
      margin: EdgeInsets.only(top: 4.0),
    );
  }

  Widget _buildButtons(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: InkWell(
              onTap: ()=> print('followed'),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(),
                  color: Color(0XFF404A5C)
                ),
                child: Center(
                  child:  Text(
                    'متابعه ',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ),
            ),
          ),
          SizedBox(width: 10.0,),
          Expanded(
            child: InkWell(
   onTap: (){ Navigator.of(context).push((MaterialPageRoute(builder: (context)=> questionPage(id: widget.id, user: widget.user ))));},//المفروض هنا هيوديه ع الصفحه الي هيبعتله فيها السؤل
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                    border: Border.all(),
                    color: Colors.white
                ),
                child: Center(
                  child: Text(
                    'أسأل الان',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0XFF404A5C),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(){
   
    return Container(
      child: Center(
        child:  Text(
          'الأسئله المجاب عنها من ${widget.currentLawyer.data['fname']} ',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20
          ),
        ),
      )
    );
  }

  Widget _buildQuestionCard(){
    TextStyle _questionTextStyle = TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.w400,
    );
    TextStyle _answerTextStyle = TextStyle(
      color: Colors.black54,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
   return   StreamBuilder<QuerySnapshot>(
       stream:  Firestore.instance.collection('info').where("lawyerid", isEqualTo: widget.id).
       where("state", isEqualTo: "     تمت الإجابة عن هذا السؤال   ").snapshots(),
       builder: (context, snapshot) {
           if (snapshot.hasData) {
                return Column(      
children: snapshot.data.documents.map((hoc) {
                return Container(
     
      margin: EdgeInsets.only(top: 8.0),
      decoration: BoxDecoration(
        color: Color(0XFFEFF4F7),
      ),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 300),
            child: Text(
              'السؤال:',
              textDirection: TextDirection.rtl,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Text(
                hoc.data['title'],
                style: _questionTextStyle,
                textDirection: TextDirection.rtl,
          ),
          Padding(
            padding: EdgeInsets.only(left: 300),
            child:   Text('الاجابه:',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                )),
          ),
          Text(
            hoc.data['answering'],
            style: _answerTextStyle,
            textDirection: TextDirection.rtl,
          ),
            Padding(
            padding: EdgeInsets.only(left: 300),
            child: Text(
              'بتاريخ:',
              textDirection: TextDirection.rtl,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Text(
                hoc.data['DateofAnswer'],
                style: TextStyle(backgroundColor: Colors.blueGrey, color: Colors.white),
                textDirection: TextDirection.rtl,
          ),
          new Row(
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          IconButton(icon: new Icon(FontAwesomeIcons.solidHeart,color: Colors.red,), alignment: Alignment.topRight,color: Colors.red,onPressed: (){},),
          IconButton(icon: new Icon(FontAwesomeIcons.share), alignment: Alignment.topRight,color: Colors.blueAccent,onPressed: (){},),
        ],
      ),
        ],
      ),
    );

     
           }).toList(),
     
       );
       
       }  else {
              return SizedBox();
  }});}
           
  //--------------------------------------BODY----------------------------------------------
  @override
  Widget build(BuildContext context) {
   Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          _buildCoverImage(screenSize),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: screenSize.height /6.4,),
                  _buildProfileImage(),
                  _buildFullName(),
                 // _buildStatContainer(),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    child: Column(
                      children: <Widget>[
                         _buildOfficeAddress(context),
                          _buildLawyerNumber(context),
                        _buildSeparator(screenSize,context),
                        SizedBox(height: 20,),
                        _buildButtons(),
                        SizedBox(height: 20,),
                        _buildTitle(),
                        _buildQuestionCard(),
                        
                      ],
                    ),
                      ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

}
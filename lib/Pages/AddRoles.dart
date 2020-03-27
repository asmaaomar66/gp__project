import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class AddRoles extends StatefulWidget{
  

  @override
  
  
  _AddRoles createState()=> new _AddRoles();

  }

    class _AddRoles extends State<AddRoles>{
  /*    Future<void> _ackAlert(BuildContext context){
return showDialog<void>(
context: context,
builder: (BuildContext context){  
  return 
  AlertDialog(
title: Text("zh2t"),
actions: <Widget>[
 IconButton(icon: new Icon(Icons.add, color: Colors.black,),
 alignment: Alignment.topRight,color: Colors.teal[900], onPressed:(){ addDynamic(); }),

],
  );
  }
);

  }*/
   TextEditingController ruleName = new TextEditingController();
  TextEditingController ruleNum = new TextEditingController();
  TextEditingController ruleContext = new TextEditingController();
  TextEditingController bnod = new TextEditingController();
  List<DynamicWidget> listDynamic = [];
      addDynamic(){
listDynamic.add(new DynamicWidget());
setState(() {
  
}); 

      }
  @override


  Widget build(BuildContext context) {
    return 
    
         Scaffold( 
           

         body: 
         
            Container( 
            padding: EdgeInsets.symmetric(vertical: 50.0,horizontal: 20.0),
           child: Column(children: <Widget>[
            
             Text("إضافة القوانين", textAlign: TextAlign.center,
                   style: TextStyle(color: Colors.lightBlueAccent,fontWeight: FontWeight.w900,fontSize: 22),),
                 
                   SizedBox(height: 20,),
                    TextFormField(
                          keyboardType: TextInputType.text,
                          autofocus: true,
                          controller: ruleName,
                          textDirection: TextDirection.rtl,
                          decoration: InputDecoration( 
                            hintText: "إدخل اسم القانون", 
                            hintStyle: TextStyle(
                              fontSize: 18,
                            ),
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                        ),

                         SizedBox(height: 20,),
                    TextFormField(
                          keyboardType: TextInputType.number,
                          autofocus: true,
                          controller: ruleNum,
                          textDirection: TextDirection.rtl,
                          decoration: InputDecoration( 
                            hintText: "إدخل رقم المادة", 
                            hintStyle: TextStyle(
                              fontSize: 18,
                            ),
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                        ),
                        SizedBox(height: 20,),
                          TextFormField(
                          keyboardType: TextInputType.text,
                          autofocus: true,
                          controller: ruleContext,
                          textDirection: TextDirection.rtl,
                          decoration: InputDecoration( 
                            hintText: "إدخل نص المادة", 
                            hintStyle: TextStyle(
                              fontSize: 18,
                            ),
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                        ),
                        
                         SizedBox(height: 20,),
                         TextFormField(
                          keyboardType: TextInputType.text,
                          autofocus: true,
                          maxLines:5,                    
                          controller: bnod,
                          //textDirection: TextDirection.rtl,
                          decoration: InputDecoration( 
                           
                            
                            hintText: "البند", 
                            hintStyle: TextStyle(
                              fontSize: 18,
                            ),
                            
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                        ),

              new Flexible(child: ListView.builder(
                itemCount: listDynamic.length,
                itemBuilder: (_,index)=>listDynamic[index])),
              IconButton(icon: new Icon(Icons.add, color: Colors.black,),
              alignment: Alignment.topRight,color: Colors.teal[900], onPressed:(){addDynamic(); }),
              new RaisedButton(
                          
                        
                        shape:new RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
                        
                        color: Colors.redAccent, 
                        textColor: Colors.white, 
                        child: new Text("إضافة", 
                        style: TextStyle(fontWeight: FontWeight.w700,fontSize: 21)), 
                        onPressed: () => {}, 
                        splashColor: Colors.lightBlueAccent,
                        ),
                        ],),
 
                        ),
                        
                      
                        
                        
                       
                        
                        );
                }


                }

  class DynamicWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(margin: EdgeInsets.only(top:30,),
    child:TextFormField(
                          keyboardType: TextInputType.text,
                          autofocus: true,
                          maxLines: 5,                    
                        //  controller: con,
                          //textDirection: TextDirection.rtl,
                          decoration: InputDecoration( 
                           
                            
                            hintText: "البند", 
                            hintStyle: TextStyle(
                              fontSize: 18,
                            ),
                            
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                        ),);

  }



  }


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/database.dart';
import 'package:todo/models/taskCard.dart';
import 'package:todo/taskWidget.dart';

 int i = 0;
class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  int get id => i;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body:SafeArea(
       child: Container(
           width: double.infinity,
           padding: EdgeInsets.all(25.0),
         child: Stack(
           children: [
             Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 // to change a block into a comment we use ctrl + shift + /
                 /*Padding(
                 padding: EdgeInsets.symmetric(
                   vertical: 24.0,
                 )),*/
                 Row(
                   children: [
                     Padding(
                         padding: const EdgeInsets.all(10.0),
                         child: InkWell(
                           onTap: (){
                             Navigator.pop(context);
                           },
                           child:Icon(
                             // replace with a beautiful arrow picture later
                             Icons.arrow_back,
                             color: Color(0xff742CFA),
                             size: 30.0,
                           ),
                         )

                     ),
                     Expanded(
                       child: TextField(
                         decoration: InputDecoration(
                           hintText: "The card Title",
                           border: InputBorder.none,
                         ),
                         style: TextStyle(
                           fontSize:26.0,
                           fontWeight: FontWeight.bold,

                         ),
                       ),
                     )
                   ],
                 ),
                 Padding(
                   padding:EdgeInsets.only(
                     bottom: 20.0,
                   ),
                   child: TextField(
                     onSubmitted: (value)async{
                       print("salam :  $value");
                       if(value != ""){
                         DatabaseToDo _dbHelper = DatabaseToDo();

                         TaskCard _newTask = TaskCard(
                              id,value, value);
                         i++;
                         await _dbHelper.insertTask(_newTask);

                         print("new task has been created");

                       }
                     },
                     decoration: InputDecoration(
                       hintText: "The card description",
                       border: InputBorder.none,
                       contentPadding: EdgeInsets.symmetric(
                         horizontal: 30.0,
                       ),
                     ),
                   ),
                 ),
                 Expanded(child: ListView(
                   children: [
                     TaskWidget("salam",true),
                     TaskWidget("love you my allah",false),
                     TaskWidget("hhhh",true),
                     TaskWidget("hey you",false),
                   ],
                 )),


               ],
             ),
             Positioned(
                 bottom: 0.0,
                 right: 0.0,

                 // we use gestureDectector so that we can call onTap function
                 child: GestureDetector(
                   onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context) => TaskPage()));
                   },
                   child: Container(
                     width: 60.0,
                     height: 60.0,
                     decoration: BoxDecoration(
                       color: Colors.purpleAccent,
                       borderRadius: BorderRadius.circular(20.5),
                     ),
                     child: Icon(
                       Icons.delete_outline,
                       color: Colors.white,
                       size: 30.0,
                     ),
                   ),
                 )


             ),

           ],
         )
       ),
       
     ),
    );
  }
}



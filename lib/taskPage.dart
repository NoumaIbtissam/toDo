

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/database.dart';
import 'package:todo/models/taskCard.dart';
import 'package:todo/models/taskItem.dart';
import 'package:todo/taskWidget.dart';
import 'package:todo/toDoCard.dart';
import 'package:flutter/src/widgets/framework.dart';


class TaskPage extends StatefulWidget {

  final int ? id;
  final TaskCard ? task;
  TaskPage({@required this.task, this.id});


  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {

  DatabaseToDo _dbHelper = DatabaseToDo();
  int taskId = 0;
  String taskTitle = "";
  String taskDescription = "";

  late FocusNode titleFocus;
  late FocusNode descriptionFocus;
  late FocusNode todoFocus;

  bool contentVisible = false;




  void initState(){
    if (widget.task != null) {
      // Set visibility to true

      // _taskTitle = widget.task.title;
      taskDescription = widget.task!.description;
      taskId = widget.task!.id!;
      // _taskId = widget.task.id;
    }

    titleFocus = FocusNode();
    descriptionFocus = FocusNode();
    todoFocus = FocusNode();

    super.initState();
  }

  void dispose(){

    titleFocus.dispose();
    descriptionFocus.dispose();
    todoFocus.dispose();
    super.dispose();
  }
  // void initState(){
  //   print("id => ${id}");
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body:SafeArea(
       child:
       Container(
           width: double.infinity,
           padding: EdgeInsets.all(25.0),
         child: Stack(
           children: [
             Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 // to change a block into a comment we use ctrl  + /
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
                         focusNode: titleFocus,
                         onSubmitted: (value) async {
                           if(value != ""){
                             //Check if the task is null
                             if(widget.task == null)
                             {
                               TaskCard _newTask = TaskCard(title: value, description: value);
                               taskId  = await _dbHelper.insertTask(_newTask);
                             }
                             else{
                               print('update the existiong task');
                             }
                           }
                           descriptionFocus.requestFocus();
                         },
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
                      focusNode: descriptionFocus,
                      onSubmitted: (value)async{

                        todoFocus.requestFocus();

                        //Check if the description field is not empty
                      },
                      controller: TextEditingController()
                        ..text = taskDescription,
                      decoration: InputDecoration(
                        hintText: "The card description",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 30.0,
                        ),
                      ),
                    ),
                  ),
                 Expanded(child:Column(
                         children: [
                           FutureBuilder<List>(
                             initialData: [],
                             future: _dbHelper.getTodos(taskId),
                             builder: (context,snapshot){
                               return Expanded(child:
                               ListView.builder(
                                 itemCount: snapshot.data == null ? 0 : snapshot.data!.length,
                                 itemBuilder: (context,index){
                                   return GestureDetector(
                                     onTap: (){

                                     },
                                     child: TaskWidget(snapshot.data![index].title ,snapshot.data![index].isDone ==0 ?false:true,),
                                   );
                                 },
                               ));
                             },
                           ),
                         ],
                       ),),
                 Column(
                   children: [
                     Row(
                       children: [
                         Padding(padding: EdgeInsets.symmetric(horizontal: 8.0),
                             child:Row(
                               children: [
                                 Container(
                                   width: 30.0,
                                   height: 30.0,
                                   decoration: BoxDecoration(
                                       color: Colors.transparent,
                                       borderRadius: BorderRadius.circular(12.0),
                                       border: Border.all(
                                         color: Color(0xff742CFA),
                                         width: 1.5,
                                       )
                                   ),
                                   child: Icon(
                                     // replace it with a beautiful checkbox picture later
                                     Icons.check,
                                     color: Colors.white,
                                     size: 20.0,
                                   ),
                                 ),
                               ],
                             )),
                         Expanded(
                         child:Column(children: [
                           TextField(
                             focusNode: todoFocus,
                             onSubmitted: (value) async {
                               if(value != ""){
                                 //Check if the task is null
                                 if(widget.task != null)
                                 {
                                   TaskItem newTaskItem = TaskItem(title: value, isDone:0,taskId: widget.task?.id);
                                   await _dbHelper.insertTaskItem(newTaskItem);
                                   setState(() {});
                                 }else
                                   print("oups it doesn't exist");

                               }
                             },
                             decoration: InputDecoration(
                               hintText: "add another toDo item",
                               border: InputBorder.none,
                             ),
                           ),
                         ],),
                         ),

                       ],
                     )
                   ],
                 ),

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

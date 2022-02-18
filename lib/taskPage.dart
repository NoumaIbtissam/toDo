import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/database.dart';
import 'package:todo/models/taskCard.dart';
import 'package:todo/models/taskItem.dart';
import 'package:todo/taskWidget.dart';
import 'package:todo/toDoCard.dart';
import 'package:flutter/src/widgets/framework.dart';

class TaskPage extends StatefulWidget {
  final int? id;
  final TaskCard? task;

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

  deleteBgItem() {
    return Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(
          left: 15.0,
          right: 24.0,
          top: 15.0,
          bottom: 15.0,
        ),
        color: Color(0xffffbf00),
        child: Icon(Icons.delete, color: Colors.white));
  }

  void delete(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text('Please Confirm'),
            content: Text('Are you sure to remove the box?'),
            actions: [
              // The "Yes" button
              TextButton(
                  onPressed: () {
                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: Text('No')),
              TextButton(
                  onPressed: () async {
                    if (taskId != null) {
                      await _dbHelper.deleteTask(taskId);
                      Navigator.pop(context);
                    }
                    setState(() {});
                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: Text('Yes')),
            ],
          );
        });
  }

  void emptyTitle(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text('Warning'),
            content: Text(
                'make sure the title filed is full or the task card won\'t becreated properly'),
            actions: [
              // The "Yes" button
              TextButton(
                  onPressed: () {
                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: Text('Ok'))
            ],
          );
        });
  }

  void initState() {
    if (widget.task != null) {
      taskTitle = widget.task!.title;
      taskDescription = widget.task!.description;
      taskId = widget.task!.id!;
    }

    titleFocus = FocusNode();
    descriptionFocus = FocusNode();
    todoFocus = FocusNode();

    super.initState();
  }

  void dispose() {
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
      backgroundColor: Color(0xFFF6F6F6),
      body: SafeArea(
        child: Container(
            width: double.infinity,
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
                        // Padding(
                        //     padding: const EdgeInsets.all(10.0),
                        //     child: InkWell(
                        //       onTap: (){
                        //
                        //         Navigator.pop(context);
                        //       },
                        //       child:Icon(
                        //         // replace with a beautiful arrow picture later
                        //         Icons.arrow_back,
                        //         color: Color(0xff742CFA),
                        //         size: 30.0,
                        //       ),
                        //     )
                        //
                        // ),
                        Expanded(
                          child: Container(
                              padding: EdgeInsets.only(
                                top: 10.0,
                                bottom: 10.0,
                                left: 10.0,
                                right: 20.0,
                              ),
                              color: Color(0xff2c0c8a),
                              child: Container(
                                color: Colors.white,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 15.0,
                                  vertical: 5.0,
                                ),
                                child: TextField(
                                  focusNode: titleFocus,
                                  onSubmitted: (value) async {
                                    if (value != "") {
                                      //Check if the task is null
                                      if (widget.task == null) {
                                        TaskCard _newTask = TaskCard(
                                            title: value, description: value);
                                        taskId = await _dbHelper
                                            .insertTask(_newTask);
                                        setState(() {
                                          taskTitle = value;
                                        });
                                      } else {
                                        await _dbHelper.updateTaskTitle(
                                            taskId, value);
                                        print("task Updated");
                                      }
                                    } else {
                                      taskTitle = "new task";
                                      if (widget.task == null) {
                                        TaskCard _newTask = TaskCard(
                                            title: taskTitle,
                                            description: taskTitle);
                                        taskId = await _dbHelper
                                            .insertTask(_newTask);
                                        setState(() {});
                                      } else {
                                        await _dbHelper.updateTaskTitle(
                                            taskId, value);
                                        print("task Updated");
                                      }
                                    }
                                    descriptionFocus.requestFocus();
                                  },
                                  controller: TextEditingController()
                                    ..text = taskTitle,
                                  decoration: InputDecoration(
                                    hintText: "The card Title",
                                    border: InputBorder.none,
                                  ),
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 20.0,
                      ),
                      child: TextField(
                        focusNode: descriptionFocus,
                        onSubmitted: (value) async {
                          if (value != "") {
                            if (taskId != null) {
                              await _dbHelper.updateTaskDescription(
                                  taskId, value);
                              taskDescription = value;
                            }
                          }
                          todoFocus.requestFocus();
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
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.all(25.0),
                      child: Column(
                        children: [
                          FutureBuilder<List>(
                            initialData: [],
                            future: _dbHelper.getTodos(taskId),
                            builder: (context, snapshot) {
                              return Expanded(
                                  child: ListView.builder(
                                itemCount: snapshot.data == null
                                    ? 0
                                    : snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  return Dismissible(
                                      key: UniqueKey(),
                                      background: deleteBgItem(),
                                      onDismissed: (direction) async {
                                        _dbHelper.deleteTaskItem(
                                            snapshot.data![index].id);
                                      },
                                      child: GestureDetector(
                                        onTap: () async {
                                          if (snapshot.data![index].isDone ==
                                              0) {
                                            await _dbHelper.updateTodoDone(
                                                snapshot.data![index].id, 1);
                                          } else {
                                            await _dbHelper.updateTodoDone(
                                                snapshot.data![index].id, 0);
                                          }
                                          setState(() {});
                                        },
                                        child: TaskWidget(
                                          snapshot.data![index].title,
                                          snapshot.data![index].isDone == 0 ? false : true,
                                        ),
                                      ));
                                },
                              ));
                            },
                          ),
                        ],
                      ),
                    )),
                    Container(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 30.0,
                                        height: 30.0,
                                        decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            border: Border.all(
                                              color: Color(0xff742CFA),
                                              width: 1.5,
                                            )),
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
                                child: Column(
                                  children: [
                                    TextField(
                                      focusNode: todoFocus,
                                      controller: TextEditingController()
                                        ..text = "",
                                      onSubmitted: (value) async {
                                        if (value != "") {
                                          //Check if the task is null
                                          if (taskId != null) {
                                            TaskItem newTaskItem = TaskItem(
                                                title: value,
                                                isDone: 0,
                                                taskId: taskId);
                                            await _dbHelper
                                                .insertTaskItem(newTaskItem);
                                            setState(() {});
                                            todoFocus.requestFocus();
                                          } else
                                            print("oups it doesn't exist");
                                        }
                                      },
                                      decoration: InputDecoration(
                                        hintText: "add  toDo item",
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                    bottom: 0.0,
                    right: 0.0,
                    // we use gestureDectector so that we can call onTap function
                    child: GestureDetector(
                      onTap: () {
                        delete(context);
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
                    )),
              ],
            )),
      ),
    );
  }
}

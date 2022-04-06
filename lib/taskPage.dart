import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:todo/database.dart';
import 'package:todo/models/taskCard.dart';
import 'package:todo/models/taskItem.dart';
import 'package:todo/taskWidget.dart';
import 'package:todo/toDoCard.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'globals.dart' as globals;


class TaskPage extends StatefulWidget {
  final int? id;
  final TaskCard? task;

  TaskPage({@required this.task, this.id});

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {

  final keyTwo = GlobalKey();
  final keyThree = GlobalKey();
  final keyFour = GlobalKey();

  final snackBar = SnackBar(
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
    // backgroundColor: Colors.blue,
    margin: EdgeInsets.only(
      bottom: 25.0,
      left: 5.0,
      right: 5.0,
    ),
    padding: EdgeInsets.all(10.0),
    content: const Text('Card created successfully',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 18),
    ),
    backgroundColor: Color(0xff26c6da),
    duration: Duration(seconds: 2),

  );
  final snackBarUpdate = SnackBar(
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
    // backgroundColor: Colors.blue,
    margin: EdgeInsets.only(
      bottom: 25.0,
      left: 5.0,
      right: 5.0,
    ),
    padding: EdgeInsets.all(10.0),
    content: const Text('Card updated successfully',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 18),
    ),
    backgroundColor: Color(0xff26c6da),
    duration: Duration(seconds: 2),

  );






  DatabaseToDo _dbHelper = DatabaseToDo();
  int taskId = 0;
  String taskTitle = "";
  String taskDescription = "";
  String todoItem = "";

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

  void addTodo(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
              title: Text('Please add a todo '),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  todoItem = value;
                });
              },
              autofocus: true,
              controller: TextEditingController()..text = "",
              decoration: InputDecoration(
                hintText: "add  toDo item",
              ),
            ),
            actions: <Widget>[
              FlatButton(
                color: Color(0xffffbf00),
                textColor: Colors.white,
                child: Text('CANCEL',
                style : TextStyle(
                    fontWeight: FontWeight. bold,
                ),),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              FlatButton(
                color: Color(0xff26c6da),
                textColor: Colors.white,
                child: Text('GO',
                  style : TextStyle(
                    fontWeight: FontWeight. bold,
                  ),),
                onPressed: () async {
                    if (todoItem != "") {
                      //Check if the task is null
                      if (taskId != null) {
                        TaskItem newTaskItem = TaskItem(
                            title: todoItem, isDone: 0, taskId: taskId);
                        await _dbHelper.insertTaskItem(newTaskItem);
                        setState(() {});
                        todoFocus.requestFocus();
                      } else
                        print("oups it doesn't exist");
                    }
                    Navigator.pop(context);
                    todoFocus.requestFocus();
                    setState(() {});
                },
              ),
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

    if(globals.showCaseFlagTaskPage == false) {
      WidgetsBinding.instance!.addPostFrameCallback(
              (_) =>
              ShowCaseWidget.of(context)!.startShowCase(
                  [
                    keyTwo,
                    keyThree,
                    keyFour,
                  ]
              ));
      globals.showCaseFlagTaskPage = true;
    }
  }

  void dispose() {
    titleFocus.dispose();
    descriptionFocus.dispose();
    todoFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      body: SafeArea(
        child: Container(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(25.0),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            child: Image(
                              width: 60.0,
                              height: 60.0,
                              image: AssetImage('assets/logo-1.png'),
                            ),
                          ),
                          Spacer(),
                          // DELETE BUTTON
                          // we use gestureDectector so that we can call onTap function
                          Showcase(
                            key:keyFour,
                            description:'press here to delete the card',
                            child: GestureDetector(
                              onTap: () {
                                delete(context);
                              },
                              child: Icon(
                                Icons.delete_outline,
                                color: Color(0xff2c0c8a),
                                size: 40.0,
                              ),
                            ),
                          ),
                        ],
                      ),

                      Showcase(
                        key:keyTwo,
                        description: 'Type to enter or update a title and make sure to hit ok in the keyboard',
                        child: Container(
                          margin: EdgeInsets.only(
                            top: 30.0,
                            right: 50.0,
                            // left:50.0,
                          ),
                          child: TextField(
                            focusNode: titleFocus,
                            onSubmitted: (value) async {
                              if (value != "") {
                                //Check if the task is null
                                if (widget.task == null) {
                                  TaskCard _newTask =
                                  TaskCard(title: value, description: value);
                                  taskId = await _dbHelper.insertTask(_newTask);
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                } else {
                                  await _dbHelper.updateTaskTitle(taskId, value);
                                  ScaffoldMessenger.of(context).showSnackBar(snackBarUpdate);
                                }
                                setState(() {
                                  taskTitle = value;
                                });

                              } else {
                                taskTitle = "new task";
                                if (widget.task == null) {
                                  TaskCard _newTask = TaskCard(
                                      title: taskTitle, description: taskTitle);
                                  taskId = await _dbHelper.insertTask(_newTask);
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                } else {
                                  await _dbHelper.updateTaskTitle(taskId, value);
                                  ScaffoldMessenger.of(context).showSnackBar(snackBarUpdate);
                                }
                              }
                              descriptionFocus.requestFocus();
                              setState(() {});
                            },
                            controller: TextEditingController()..text = taskTitle,
                            decoration: InputDecoration(
                              hintText: "The card Title",
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      // ),
                      //DESCRIPTION FIELD
                      Showcase(
                        key:keyThree,
                        description: 'Type to enter or update a description and make sure to hit ok in the keyboard',
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
                            setState(() {});
                            // todoFocus.requestFocus();
                          },
                          controller: TextEditingController()
                            ..text = taskDescription,
                          decoration: InputDecoration(
                            hintText: "The card description",
                            border: InputBorder.none,
                            // contentPadding: EdgeInsets.only(
                            //   right: 5.0,
                            // ),
                          ),
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                      ),

                      // TODOS
                      Expanded(
                          child: Container(
                        margin: EdgeInsets.only(
                          top: 20.0,
                        ),
                        child: Column(
                          children: [
                            FutureBuilder<List>(
                              initialData: [],
                              future: _dbHelper.getTodos(taskId),
                              builder: (context, snapshot) {
                                return Expanded(
                                    child: ListView.builder(
                                  itemCount: snapshot.data == null ? 0 : snapshot.data!.length,
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
                                            setState(() {});
                                            if (snapshot.data![index].isDone == 0) {
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

                                        ),
                                    );
                                  },
                                ));
                              },
                            ),
                          ],
                        ),
                      )),
                      // ADD A TODOITEM FIELD
                    ],
                  ),
                  Positioned(
                      bottom: 0.0,
                      right: 0.0,
                      child: GestureDetector(
                        onTap: () {
                          addTodo(context);
                        },
                        child: Container(
                          width: 60.0,
                          height: 60.0,
                          decoration: BoxDecoration(
                            color: Color(0xff2c0c8a),
                            borderRadius: BorderRadius.circular(20.5),
                          ),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 30.0,
                          ),
                        ),
                      )),
                ],

              ),
            )),
      ),
    );
  }
}

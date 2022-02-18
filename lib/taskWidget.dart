import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'database.dart';


class TaskWidget extends StatelessWidget {
  late final String task;
  late final bool isDone;
  DatabaseToDo _dbHelper = DatabaseToDo();
  int id = 0;

  TaskWidget(@required this.task,@required this.isDone);


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
      Container(
          margin: EdgeInsets.only(
              bottom: 15.0,
            top: 10.0,
          ),
          padding: EdgeInsets.only(
            left: 15.0,
            right: 24.0,
            top: 15.0,
            bottom: 15.0,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 20.0,
                height: 20.0,
                decoration: BoxDecoration(
                    color: isDone ? Color(0xff2c0c8a) : Colors.transparent,
                    // borderRadius: BorderRadius.circular(12.0),
                    border: isDone ? null : Border.all(
                      color: Color(0xff2c0c8a),
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

              Flexible(child:Container(
                child: Text( task ?? "new task",
                  style: TextStyle(
                    fontSize:16.0,
                    fontWeight: isDone ? FontWeight.bold : FontWeight.w600,
                    color: isDone ? Colors.black : Colors.black38,

                  ),),
                margin: EdgeInsets.only(
                  left: 6.0,
                ),

              ),
              ),
            ],
          )
      ),
      Positioned(
          right: 0.0,
          bottom: 0.0,
          // we use gestureDectector so that we can call onTap function
          child: GestureDetector(
            onTap:() async{
              await _dbHelper.deleteTaskItem(id);
            } ,
            child: Container(
              width: 35.0,
              height: 35.0,
              decoration: BoxDecoration(
                color: Color(0xFFF6F6F6),
                borderRadius: BorderRadius.circular(20.5),
              ),
              child: Icon(
                Icons.arrow_back,
                color: Colors.blueGrey,
                size: 25.0,
              ),
            ),
          )


      ),

    ],);

  }
}


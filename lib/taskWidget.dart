import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class TaskWidget extends StatelessWidget {
  late final String task;
  late final bool isDone;
  TaskWidget(@required this.task,@required this.isDone);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 15.0,
        horizontal: 24.0,
      ),
      child: Row(
        children: [
          Container(
            width: 30.0,
            height: 30.0,
            decoration: BoxDecoration(
              color: isDone ? Color(0xff742CFA) : Colors.transparent,
              borderRadius: BorderRadius.circular(12.0),
              border: isDone ? null : Border.all(
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
          Container(
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
        ],
      )
    );
  }
}


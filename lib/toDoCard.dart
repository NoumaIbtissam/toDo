
import 'package:flutter/material.dart';

class ToDoCard extends StatelessWidget {
  late final String title;
  late final String description;
  ToDoCard(this.title,this.description);
  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
          bottom: 20.0
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 30.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            //padding: EdgeInsets.all(5.0),
            child:Text(
              title ?? "Card Title",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold,),),
          ),
          Container(
            padding: EdgeInsets.only(
              top: 10.0,
            ),
            child:Text(
              description ?? "Card Description",style: TextStyle(color: Colors.black26,fontSize: 15,height:1.5,),),
          ),


        ],
      ),
    );
  }
}

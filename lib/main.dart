import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/home.dart';

import 'loader.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 409,
              height: 620,
              child: Image.asset("assets/background.jpg", fit: BoxFit.contain,),
          ),
          Positioned(
              child: Text("ToDos",style: TextStyle(color: Colors.white,fontSize: 40,fontWeight: FontWeight.bold),),
                      top: 40,
                      left: 120,),
        ],
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/home.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => Home()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2c0c8a),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 409,
            height: 620,
            child: Image.asset("assets/splash_transparent.gif", fit: BoxFit.contain,),
          ),
          Container(
            // child: Center(child:
            // // Text("Big achievements starts with small steps",
            // //   style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),
            // //     textAlign: TextAlign.center)
            //   ),
              margin: const EdgeInsets.only(top: 300.0,left: 20)),
        ],
      ),
    );
  }
}

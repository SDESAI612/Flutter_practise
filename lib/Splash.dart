import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class Splash extends StatefulWidget{
  @override
  _Splash createState() => _Splash();

}

class _Splash extends State<Splash>{

  @override
  Widget build(BuildContext context) {

   return Scaffold(
     body: Center(
        child: Container(
          height:MediaQuery.of(context).size.height,
          child: Image.asset('assets/splash.jpg', fit: BoxFit.fitHeight),
          ),
        ),
   );

  }


 void navigationPage() {

   Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => MyHomePage()));

 }


   startTime() async{

  var _duration = new Duration(seconds: 3);
  return new Timer(_duration, navigationPage);

  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

}
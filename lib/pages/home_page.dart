import 'dart:async';

import 'package:flutter/material.dart';
import 'package:laboratorio_app2/costum_widgets/generic_widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void _loadNextPage(){
    Navigator.pushReplacementNamed(context, 'login_page');
  }

  startTimer(){
    var duration = new Duration(seconds: 2);
    return new Timer(duration, _loadNextPage);
  }

  @override 
  void initState(){
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            bigText("Laboratorio App", Colors.redAccent[400]),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                  top: 40, left: screenwidth * 0.4, right: screenwidth * 0.4),
              child: CircularProgressIndicator(
                strokeWidth: 10,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent[400]),
              ),
            )
          ]),
        ),
      ),
    );
  }
}

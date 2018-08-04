import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';

import 'bottomnav.dart';
import 'login.dart';

//This page decides if the user has a saved access token and navigates to
// a different page based on that

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  //initiating checkUser so the logic can be processed on start up
  @override
  void initState() {
    super.initState();
    //delaying for 2 seconds and initiating checkUser() method
    Timer(Duration(seconds: 2), () => checkUser());
  }

  @override
  Widget build(BuildContext context) {
    //maybe add a quick animation or icon?
    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(color: Colors.yellow),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 50.0,
                      child: Text(
                        "Yime",
                        style: TextStyle(
                            fontSize: 35.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        "Know when your squad is free.",
                        style: TextStyle(fontSize: 15.0),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        )
      ],
    ));
  }

  Future<Null> checkUser() async {
    //calling shared pref plugin and getString()
    String _token;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString("accesstoken");
    //checking the token
    if (_token == "error" || _token == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login()));
      //your home page is loaded
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => BottomNavigation()));
    }
  }
}

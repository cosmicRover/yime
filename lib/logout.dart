import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';

import 'login.dart';

//This page simply deletes the accesstoken of a user and directs them to Login

class LogOut extends StatefulWidget {
  @override
  _LogOutState createState() => _LogOutState();
}

class _LogOutState extends State<LogOut> {
  //initiating deleteAcToken so the logic can be processed on entering
  @override
  void initState() {
    super.initState();
    //delaying for 2 seconds and initiating deleteAcToken() method
    Timer(Duration(seconds: 1), () => deleteAcToken());
  }

  @override
  Widget build(BuildContext context) {
    //Showing the user that we are logging them out
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
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          "Logging you out!",
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  //function that deletes the accesstoken
  Future<Null> deleteAcToken() async {
    //calling shared pref plugin and getString()
    //String _token;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("accesstoken");
    print("deleted acToken");
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Login()));
  }
}

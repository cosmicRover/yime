import 'package:flutter/material.dart';

import 'dart:async';

import 'saveaccesscode.dart';
import 'bottomnav.dart';
import 'login.dart';

AcCodeStorage saveKey = AcCodeStorage();
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
    //showing a little splash screen
    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(color: Colors.white),
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
                    Text("Yime", style: TextStyle(fontSize: 95.0)),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        "Know when your squad is free.",
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.bold),
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
    saveKey.readAcCode().then((onValue) {
      _token = onValue.toString();

      if (_token == "null") {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Login()));
        //your home page is loaded
        print(onValue);
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => BottomNavigation()));
        print('else $onValue');
      }
    });
  }
}

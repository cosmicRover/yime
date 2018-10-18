import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pimp_my_button/pimp_my_button.dart';
import 'dart:async';
import 'dart:convert';

import './wsinitial.dart';
import './saveaccesscode.dart';

class Discover extends StatefulWidget {
  @override
  _DiscoverState createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  static String accessToken;
  static String authCode;
  int userId;
  AcCodeStorage saveKey = AcCodeStorage();

  static const _serviceUrl =
      'https://yime.herokuapp.com/api/me'; //schedule, available, friend and me(coming soon)
  static final _headers = {
    'Authorization': authCode,
    'Content-Type': 'application/json'
  };

  //gets userId from api
  Future<dynamic> getUserId() async {
    accessToken = await saveKey.readAcCode();
    authCode = 'Bearer '+accessToken;
    print(authCode);
    try {
      final responseSchedule = await http.get(_serviceUrl, headers: _headers);
      var r = jsonDecode(responseSchedule.body);
      r = r['id'];
      userId = r;
      print(userId);
      return userId;
    } catch (e) {
      print('Server Exception!!! on getinfo ');
      print(e);
      return e;
    }
  }

  @override
  void initState() {
    super.initState();
    getUserId();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Theme(
        data: ThemeData(
            primarySwatch: Colors.yellow,
            canvasColor: Colors.white,
            splashColor: Colors.yellow),
        child: Scaffold(
          appBar: AppBar(
            title: Text("Yime"),
          ),
          body: ListView(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Discover!",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 8.0, left: 8.0, right: 8.0, bottom: 30.0),
                    child: Text(
                      "Find new people from your community! We randomly connect you with another person to chat.",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  PimpedButton(
                      particle: DemoParticle(),
                      pimpedWidgetBuilder: (context, controller){
                        return SizedBox(
                          width: 180.0,
                          height: 50.0,
                          child: RaisedButton(
                              child: Text(
                                "Let's discover!",
                                style: TextStyle(
                                    fontSize: 20.0, fontWeight: FontWeight.bold),
                              ),
                              color: Colors.yellow,
                              onPressed: () {
                                controller.forward(from: 0.0);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WebSocket(userId)));
                              }),
                        );
                      }
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 75.0),
                    child: Image.asset(
                      "pics/discover.png",
                      scale: 1.5,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'schedule.dart';
import 'logout.dart';

import 'dart:async';
import 'dart:convert';

class Me extends StatefulWidget {
  @override
  MeState createState() => new MeState();
}

class MeState extends State<Me> {
  var userName = "";
  var freeToday = "Times that we are free today.";
  var freeTomorrow = "Times that we are free tomorrow";
  static String accessToken;
  static String authCode;

  static const _serviceUrl = 'https://yime.herokuapp.com/api/available';
  static final _headers = {
    'Authorization': authCode,
    'Content-Type': 'application/json'
  };

  @override
  void initState() {
    super.initState();
    checkUser(); //initiating the function to load accesskey
    //getInfo();
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
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "User Name",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 35.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "Today",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, left: 8.0),
                child: Text(freeToday),
              ),
              Divider(
                height: 20.0,
                indent: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "Tomorrow",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 15.0, bottom: 85.0, left: 8.0),
                child: Text(freeTomorrow),
              ),
              Divider(
                height: 20.0,
                indent: 30.0,
              ),
              FlatButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SetSchedule()));
                },
                child: Text(
                  "Edit your schedule",
                ),
              ),
              Divider(
                height: 20.0,
                indent: 20.0,
              ),
              FlatButton(
                  onPressed: () => print("pressed"),
                  child: Text("Change Name")),
              Divider(
                height: 20.0,
                indent: 20.0,
              ),
              FlatButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LogOut()));
                  },
                  child: Text("Logout")),
              Divider(
                height: 20.0,
                indent: 20.0,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> getInfo() async {
    //this function will get the response for api/me and then it will assign
    //the proper values to the variables
    try {
      final response =
          await http.get(Uri.encodeFull(_serviceUrl), headers: _headers);
      var c = jsonDecode(response.body);
      print(c);
      return c;
    } catch (e) {
      print('Server Exception!!! on getinfo ');
      print(e);
      return e;
    }
  }

  Future<Null> checkUser() async {
    //calling shared pref plugin and getString()
    SharedPreferences prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString("accesstoken");
    print("accesstoken retreived");
    authCode = 'Bearer ' +
        accessToken; //adding bearer to accesscode for security reason
    print(authCode);
    getInfo(); //calling the http.get function
  }
}

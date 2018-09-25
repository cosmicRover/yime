import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:badge/badge.dart';

import './logout.dart';
import './schedule.dart';
import './displayrequests.dart';
import './changename.dart';

String accessToken;
String authCode;
String _serviceUrl = 'https://yime.herokuapp.com/api/me';
final _headers = {
  'Authorization': authCode,
  'Content-Type': 'application/json'
};

Future<Post> fetchPost() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  accessToken = prefs.getString("accesstoken");
  print("accesstoken retreived");
  authCode =
      'Bearer ' + accessToken; //adding bearer to accesscode for security reason
  print(authCode);

  final response =
      await http.get(Uri.encodeFull(_serviceUrl), headers: _headers);
  print(response.body);

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return Post.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class Post {
  final String name, phonenumber, timezone, today, tomorrow, shareLink;
  final int friendRequestCounter;

  Post(
      {this.name,
      this.phonenumber,
      this.timezone,
      this.today,
      this.tomorrow,
      this.shareLink,
      this.friendRequestCounter});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        name: json['name'],
        phonenumber: json['phonenumber'],
        timezone: json['timezone'],
        today: json['today'],
        tomorrow: json['tomorrow'],
        friendRequestCounter: json['friendRequestCounter'],
        shareLink: json['shareLink']);
  }
}

class Me extends StatefulWidget {
  @override
  MeState createState() => new MeState();
}

//getting the json data from the api
class MeState extends State<Me> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<dynamic> checkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        return "connected";
      }
    } on SocketException catch (_) {
      print('not connected');
      return "not connectted";
    }
  }

  Future<dynamic> setData(ClipboardData data) async {
    await SystemChannels.platform.invokeMethod(
      'Clipboard.setData',
      <String, dynamic>{
        'text': data.text,
      },
    );
  }

  void showErrMessage(String message, Color c) {
    _scaffoldKey.currentState
        .showSnackBar(SnackBar(backgroundColor: c, content: Text(message)));
  }

  var style = TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0);
  var buttonStyle = TextStyle(fontSize: 15.0);

  @override
  Widget build(BuildContext context) {
    return new Material(
      child: Theme(
        data: ThemeData(
            primarySwatch: Colors.yellow,
            canvasColor: Colors.white,
            splashColor: Colors.yellow),
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text("Yime"),
            actions: <Widget>[
              FlatButton.icon(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LogOut()));
                  },
                  icon: Icon(Icons.directions_run),
                  label: Text(
                    "Logout",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ))
            ],
          ),
          body: Stack(
            children: <Widget>[
              Container(
                //future builder takes same parameter as http.get function
                child: FutureBuilder<Post>(
                  future: fetchPost(), //calling the fetch function
                  builder: (context, snapshot) {
                    //builder takes context and snapshot
                    if (snapshot.hasData) {
                      //if the snapshot contains data
                      return new ListView(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Center(
                                child: Text(
                              snapshot.data.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 45.0),
                            )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 20.0, bottom: 8.0, left: 8.0),
                            child: Text(
                              "Today",
                              style: style,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(snapshot.data.today),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 20.0, bottom: 8.0, left: 8.0),
                            child: Text(
                              "Tomorrow",
                              style: style,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(snapshot.data.tomorrow),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Divider(),
                          ),
                          FlatButton(
                              onPressed: () {
                                checkConnection().then((onValue) {
                                  print("value passed $onValue");
                                  if (onValue == 'connected') {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SetSchedule()));
                                  } else {
                                    showErrMessage(
                                        "Are you connected to the internet",
                                        Colors.red);
                                  }
                                });
                              },
                              child: Text(
                                "Edit your schedule",
                                style: buttonStyle,
                              )),
                          Divider(
                            height: 10.0,
                          ),
                          FlatButton(
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChangeName())),
                              child: Text(
                                "Change your name",
                                style: buttonStyle,
                              )),
                          Divider(
                            height: 10.0,
                          ),
                          Center(
                            child: Badge.right(
                              child: FlatButton(
                                  onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DisplayFriendRequest())),
                                  child: Text(
                                    "Friend requests",
                                    style: buttonStyle,
                                  )),
                              value: snapshot.data.friendRequestCounter.toString(),
                              color: Colors.yellow[700],
                              positionTop: 0.0,
                              positionLeft: 120.0,
                              textStyle: TextStyle(color: Colors.black),
                            ),
                          ),
                          Divider(
                            height: 10.0,
                          ),
                          FlatButton(
                              onPressed: () {
                                setData(ClipboardData(
                                        text:
                                            "https://yime.app/u/url/${snapshot.data.shareLink}"))
                                    .then((onValue) {
                                  showErrMessage("Copied!", Colors.green);
                                });
                              },
                              child: Text(
                                "Copy your schedule url",
                                style: buttonStyle,
                              ))
                        ],
                      );
                    } else if (snapshot.hasError) {
                      //if the snapshot has error
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Are you connected to the internet?",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 28.0),
                            ),
                          ),
                          FlatButton.icon(
                              onPressed: () {
                                setState(() {
                                  fetchPost();
                                });
                              },
                              icon: Icon(Icons.refresh),
                              label: Text("Tap to refresh"))
                        ],
                      );
                    }
                    // By default, show a linear progress indicator
                    return LinearProgressIndicator();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

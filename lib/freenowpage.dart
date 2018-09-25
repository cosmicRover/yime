import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import './friendprofile.dart';
import './friendrequest.dart';
import './schedule.dart';

//In this page, I'm attempting to retrieve all the friends that are online
class FreeNow extends StatefulWidget {
  @override
  FreeNowState createState() => new FreeNowState();
}

//this class indicates the values that we will be using on the app
class User {
  String name, phonenumber;
  int id;
  User({this.name, this.id, this.phonenumber});
}

//getting the json data from the api
class FreeNowState extends State<FreeNow> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  static String accessToken;
  static String authCode;
  var onlineFriends = 0;
  var scheduleChecker = -1;
  bool scheduleStopper = false;
  String friendId;

  static const _serviceUrl =
      'https://yime.herokuapp.com/api/available'; //schedule, available, friend and me(coming soon)
  static final _headers = {
    'Authorization': authCode,
    'Content-Type': 'application/json'
  };

  Future<List<User>> fetchUsersFromGitHub() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString("accesstoken");
    print("accesstoken retreived");
    authCode = 'Bearer ' +
        accessToken; //adding bearer to accesscode for security reason
    print(authCode);
    try {
      final response =
          await http.get(Uri.encodeFull(_serviceUrl), headers: _headers);
      var c = jsonDecode(response.body);
      print(c);
      List responseJson = c;
      print("data retrieved $c");
      List<User> userList = createUserList(responseJson);
      //built in sorting algorithm on dart
      userList.sort((a, b) {
        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      });
      return userList;
    } catch (e) {
      print('Server Exception!!! on getinfo ');
      print(e);
      return e;
    }
  }

  //get's schedule information
  Future<dynamic> measureScheduleLength() async {
    try {
      final responseSchedule = await http.get(
          Uri.encodeFull('https://yime.herokuapp.com/api/me'),
          headers: _headers);
      var d = jsonDecode(responseSchedule.body);
      d = d['schedule'];
      d = d['monday'].length +
          d['tuesday'].length +
          d['wednesday'].length +
          d['thursday'].length +
          d['friday'].length +
          d['saturday'].length +
          d['sunday'].length;
      scheduleChecker = d;
      print("Schedule is $d");
      if (scheduleChecker == 0) {
        showErrMessage("Your schedule is empty!", Colors.red);
      }
      return scheduleChecker;
    } catch (e) {
      print('Server Exception!!! on getinfo ');
      print(e);
      return e;
    }
  }

  var addedOnline = false;
//creating a list of users with three values retrieved from api
  List<User> createUserList(List data) {
    List<User> list = List();
    for (int i = 0; i < data.length; i++) {
      String title = data[i]["name"];
      int id = data[i]["id"];
      String phonenumber = data[i]["phonenumber"];
      User user = User(name: title, id: id, phonenumber: phonenumber);
      list.add(user);
    }
    if (addedOnline == false) {
      addedOnline = true;
      setState(() {
        onlineFriends = list.length;
        print("set called");
      });
    }
    return list;
  }

  Future<dynamic> setId(String x) async {
    friendId = x;
    return friendId;
  }

  void showErrMessage(String message, Color c) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: c,
      content: Text(message),
      duration: Duration(seconds: 5),
      action: SnackBarAction(
          label: "Set Schedule!",
          onPressed: () {
            checkConnection().then((onValue) {
              if (onValue == "connected") {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SetSchedule()));
              } else {
                showErrMessage(
                    "Internet connection lost! Connect and try again",
                    Colors.red);
              }
            });
          }),
      //duration: Duration(),
    ));
  }

  //checks if connected to the internet
  //temporary fix for messy schedule page
  //remove once fixed
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

  @override
  Widget build(BuildContext context) {
    return Material(
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
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FriendRequest())),
                  icon: Icon(Icons.person_add),
                  label: Text(
                    "Add freinds",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ))
            ],
          ),
          body: SafeArea(
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Free Now: $onlineFriends",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 8.0),
                  child: Container(
                    //future builder takes same parameter as http.get function
                    child: FutureBuilder<List<User>>(
                      future:
                          fetchUsersFromGitHub(), //calling the fetch function
                      builder: (context, snapshot) {
                        //builder takes context and snapshot
                        if (snapshot.hasData) {
                          //calling to measure schedule
                          //if statement prevents schedule from displaying twice
                          if (scheduleStopper == false) {
                            measureScheduleLength();
                            scheduleStopper = true;
                          }
                          //if the snapshot contains data
                          return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      ListTile(
                                        leading: Icon(
                                          Icons.check_circle,
                                          color: Colors.green,
                                        ),
                                        title: Text(snapshot.data[index].name),
                                        subtitle: Text(
                                            snapshot.data[index].phonenumber),
                                        onTap: () {
                                          setId(snapshot.data[index].id
                                                  .toString())
                                              .then((onValue) {
                                            print(friendId);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        FriendProfile(
                                                            friendId)));
                                          });
                                        }, //id being passed for profile request
                                      ),
                                      //Divider()
                                    ]);
                              });
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
                                      fontWeight: FontWeight.bold,
                                      fontSize: 28.0),
                                ),
                              ),
                              FlatButton.icon(
                                  onPressed: () {
                                    setState(() {
                                      fetchUsersFromGitHub();
                                    });
                                  },
                                  icon: Icon(Icons.refresh),
                                  label: Text("Tap to refresh"))
                            ],
                          );
                        }
                        // By default, show a linear progress indicator
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: LinearProgressIndicator(),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //The bottom sheet function for the list tile onTap Property
  mainBottomSheet(BuildContext context, String id, String name) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.schedule),
                title: Text("See $name's schedule"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FriendProfile(id)));
                },
              )
            ],
          );
        });
  }
}
